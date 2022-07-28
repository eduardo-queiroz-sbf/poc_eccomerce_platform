import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:foundation/generator/convention/clean_conventions.dart';
import 'package:foundation/generator/infra/resolvers/dependency_resolver.dart';
import 'package:injectable/injectable.dart';
import 'package:foundation/generator/infra/models/dependency_config.dart';
import 'package:foundation/generator/infra/resolvers/importable_type_resolver.dart';
import 'package:foundation/generator/infra/utils.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _typeChecker = TypeChecker.fromRuntime(Injectable);
const TypeChecker _moduleChecker = TypeChecker.fromRuntime(Module);

class FoundationConvention implements Generator {
  late RegExp _classNameMatcher, _fileNameMatcher;

  FoundationConvention(Map options) {
    _classNameMatcher = RegExp(CleanConventions.conventions
        .map((element) => element.classPattern)
        .join("|"));

    _fileNameMatcher = RegExp(
        CleanConventions.conventions.map((element) => element.path).join("|"));
  }

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final allDepsInStep = <DependencyConfig>[];
    var resolver = buildStep.resolver;

    if (library.classes.isEmpty) return "";

    for (var clazz in library.classes) {
      //Annotations override conventions
      if (_moduleChecker.hasAnnotationOfExact(clazz)) {
        throwIf(
          !clazz.isAbstract,
          '[${clazz.name}] must be an abstract class!',
          element: clazz,
        );
        final executables = <ExecutableElement>[
          ...clazz.accessors,
          ...clazz.methods,
        ];
        for (var element in executables) {
          if (element.isPrivate) continue;
          allDepsInStep.add(
            DependencyResolver(
              getResolver(await buildStep.resolver.libraries.toList()),
            ).resolveAnnotation(clazz, element),
          );
        }
      } else if (_hasInjectable(clazz) || _hasConventionalMatch(clazz)) {
        final currentConvention = CleanConventions.conventions.firstOrNull(
            (element) => RegExp(element.classPattern).hasMatch(clazz.name));

        if (currentConvention != null) {
          throwIf(
            currentConvention.inferenceType ==
                    InferenceType.uniqueByFirstInterface &&
                clazz.interfaces.isEmpty,
            "A classe ${clazz.name} identificada pela interface nao possui interface",
          );

          throwIf(
            currentConvention.inferenceType ==
                    InferenceType.multipleByInteger &&
                clazz.interfaces.isEmpty,
            "A classe ${clazz.name} identificada pela interface nao possui interface",
          );

          allDepsInStep.add(
            DependencyResolver(
              getResolver(await buildStep.resolver.libraries.toList()),
            ).resolveConvention(
              clazz,
              currentConvention.inferenceType ==
                          InferenceType.uniqueByFirstInterface ||
                      currentConvention.inferenceType ==
                          InferenceType.multipleByInteger ||
                      currentConvention.inferenceType ==
                          InferenceType.multipleByClassName
                  ? clazz.interfaces.first.element
                  : null,
              currentConvention.injectableType,
            ),
          );
        }
      }
    }
    return allDepsInStep.isNotEmpty ? jsonEncode(allDepsInStep) : null;
  }

  ImportableTypeResolver getResolver(List<LibraryElement> libs) {
    return ImportableTypeResolverImpl(libs);
  }

  bool _hasInjectable(ClassElement element) {
    return _typeChecker.hasAnnotationOf(element);
  }

  bool _hasConventionalMatch(ClassElement clazz) {
    if (clazz.isAbstract) {
      return false;
    }

    final fileName = clazz.source.shortName.replaceFirst('.dart', '');
    return _classNameMatcher.hasMatch(clazz.name);
  }
}
