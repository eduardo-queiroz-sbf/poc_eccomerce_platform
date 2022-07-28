import 'dart:convert';

import 'package:build_test/build_test.dart';
import 'package:collection/collection.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:foundation/generator/convention/clean_conventions.dart';
import 'package:glob/glob.dart';
import 'package:injectable/injectable.dart';
import 'package:foundation/generator/infra/code_builder/builder_utils.dart';
import 'package:foundation/generator/infra/code_builder/library_builder.dart';
import 'package:foundation/generator/infra/models/dependency_config.dart';
import 'package:foundation/generator/infra/models/importable_type.dart';
import 'package:foundation/generator/infra/resolvers/importable_type_resolver.dart';
import 'package:source_gen/source_gen.dart';

import '../utils.dart';

class FoundationConfig extends GeneratorForAnnotation<InjectableInit> {
  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final generateForDir = annotation
        .read('generateForDir')
        .listValue
        .map((e) => e.toStringValue());

    var assetReader = await PackageAssetReader.currentIsolate(
        rootPackage: buildStep.inputId.package);

    final usesNullSafety = annotation.read('usesNullSafety').boolValue;

    var targetFile = element.source?.uri;
    var preferRelativeImports =
        annotation.read("preferRelativeImports").boolValue;

    final jsonData = <Map>[];
    final cachedAssets =
        await assetReader.findAssets(Glob("**/**.injectable.json")).toList();
    for (final id in cachedAssets) {
      final json = jsonDecode(await assetReader.readAsString(id));
      jsonData.addAll([...json]);
    }

    final deps = <DependencyConfig>[];
    jsonData.forEach((json) => deps.add(DependencyConfig.fromJson(json)));

    final initializerName = annotation.read('initializerName').stringValue;
    final asExtension = annotation.read('asExtension').boolValue;

    final typeResolver =
        ImportableTypeResolverImpl(await buildStep.resolver.libraries.toList());
    final ignoredTypes =
        annotation.read('ignoreUnregisteredTypes').listValue.map(
              (e) => typeResolver.resolveType(e.toTypeValue()!),
            );
    final ignoreTypesInPackages = annotation
        .read('ignoreUnregisteredTypesInPackages')
        .listValue
        .map((e) => e.toStringValue())
        .where((e) => e != null)
        .cast<String>();

    _reportMissingDependencies(
        deps, ignoredTypes, ignoreTypesInPackages, targetFile);
    final overridedDeps =
        _overrideDependencies(deps, buildStep.inputId.package);
    final resolvedDeps = _validateDuplicateDependencies(overridedDeps);
    final generator = LibraryGenerator(
      dependencies: resolvedDeps,
      targetFile: preferRelativeImports ? targetFile : null,
      initializerName: initializerName,
      asExtension: asExtension,
    );
    final generatedLib = generator.generate();
    final emitter = DartEmitter(
      allocator: Allocator.simplePrefixing(),
      orderDirectives: true,
      useNullSafetySyntax: usesNullSafety,
    );
    return DartFormatter().format(generatedLib.accept(emitter).toString());
  }

  void _reportMissingDependencies(
      List<DependencyConfig> deps,
      Iterable<ImportableType> ignoredTypes,
      Iterable<String> ignoredTypesInPackages,
      Uri? targetFile) {
    final messages = [];
    deps.forEach((dep) {
      for (var iDep in dep.dependencies.where(
          (d) => !d.isFactoryParam && d.instanceName != kEnvironmentsName)) {
        if ((ignoredTypes.contains(iDep.type) ||
            (iDep.type.import == null ||
                ignoredTypesInPackages.any(
                  (type) => iDep.type.import!.startsWith('package:$type'),
                )))) {
          continue;
        }

        final possibleDeps = lookupPossibleDeps(iDep, deps);

        if (possibleDeps.isEmpty) {
          messages.add(
              "[${dep.typeImpl}] depends on unregistered type [${iDep.type}] ${iDep.type.import == null ? '' : 'from ${iDep.type.import}'}");
        } else {
          final availableEnvs = possibleDeps
              .map((e) => e.environments)
              .reduce((a, b) => a + b)
              .toSet();
          if (availableEnvs.isNotEmpty) {
            final missingEnvs =
                dep.environments.toSet().difference(availableEnvs);
            if (missingEnvs.isNotEmpty) {
              messages.add(
                  '[${dep.typeImpl}] ${dep.environments.toSet()} depends on Type [${iDep.type}] ${iDep.type.import == null ? '' : 'from ${iDep.type.import}'} \n which is not available under environment keys $missingEnvs');
            }
          }
        }
      }
    });

    if (messages.isNotEmpty) {
      messages.add(
          '\nDid you forget to annotate the above class(s) or their implementation with @injectable? \nor add the right environment keys?');
      printBoxed(messages.join('\n'),
          header: "Missing dependencies in ${targetFile?.path}\n");
    }
  }

  List<DependencyConfig> _overrideDependencies(
    List<DependencyConfig> deps,
    String currentPackage,
  ) {
    List<DependencyConfig> depsValues = [];
    for (var dep in deps) {
      if (dep.typeImpl.import!.contains(currentPackage)) {
        final generalImp = deps.firstWhereOrNull((element) =>
            !element.typeImpl.import!.contains(currentPackage) &&
            dep.typeImpl.import!
                    .replaceFirst("package:$currentPackage/features/", "") ==
                element.typeImpl.import!.replaceFirst("package:", ""));

        if (generalImp != null) {
          depsValues.add(
            dep.copyWith(
              type: generalImp.type,
            ),
          );
        } else {
          depsValues.add(dep);
        }
      } else if (deps
          .where((element) =>
              element.typeImpl.import!.contains(currentPackage) &&
              element.typeImpl.import!
                      .replaceFirst("package:$currentPackage/features/", "") ==
                  dep.typeImpl.import!.replaceFirst("package:", ""))
          .isEmpty) {
        depsValues.add(dep);
      }
    }

    return depsValues;
  }

  List<DependencyConfig> _validateDuplicateDependencies(
      List<DependencyConfig> deps) {
    List<DependencyConfig> depsValues = [];
    for (var dep in deps) {
      final multipleImpl = deps.where((element) => dep.type == element.type);
      final multipleImplWithoutName =
          multipleImpl.where((element) => element.instanceName == null);

      if (multipleImplWithoutName.isNotEmpty) {
        final convention = CleanConventions.conventions.singleWhereOrNull(
            (element) => RegExp(element.classPattern)
                .hasMatch(multipleImpl.first.typeImpl.name));

        if (convention!.inferenceType == InferenceType.multipleByInteger) {
          depsValues.addAll(
            multipleImpl.mapIndexed((index, element) {
              return element.copyWith(instanceName: index.toString());
            }),
          );
        } else if (convention!.inferenceType ==
            InferenceType.multipleByClassName) {
          depsValues.addAll(
            multipleImpl.map((element) {
              return element.copyWith(instanceName: element.typeImpl.name);
            }),
          );
        } else if (multipleImpl.length > 1) {
          throwBoxed(
              '${dep.typeImpl} [${dep.type}] env: ${dep.environments} \nis registered more than once under the same environment');
        } else {
          depsValues.add(dep);
        }
      }
    }
    return depsValues;
  }
}
