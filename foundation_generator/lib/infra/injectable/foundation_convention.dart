import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:foundation_generator/convention/injectable_conventions.dart';
import 'package:injectable_generator/generators/injectable_generator.dart';
import 'package:injectable_generator/models/dependency_config.dart';
import 'package:injectable_generator/utils.dart';
import 'package:source_gen/source_gen.dart';

import 'core/dependency_resolver.dart';

class FoundationConvention extends InjectableGenerator {
  late RegExp _classNameMatcher, _fileNameMatcher;

  FoundationConvention(Map options) : super(options) {
    _classNameMatcher = RegExp(CleanConventions.conventions
        .map((element) => element.classPattern)
        .join("|"));

    _fileNameMatcher = RegExp(
        CleanConventions.conventions.map((element) => element.path).join("|"));
  }

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final allDepsInStep = <DependencyConfig>[];

    if (library.classes.isEmpty) return "";

    for (var clazz in library.classes) {
      if (_hasConventionalMatch(clazz)) {
        final currentConvention = CleanConventions.conventions.firstOrNull(
            (element) => RegExp(element.classPattern).hasMatch(clazz.name));

        throwIf(
          currentConvention!.inferenceType ==
                  InferenceType.uniqueByFirstInterface &&
              clazz.interfaces.isEmpty,
          "A classe ${clazz.name} identificada pela interface nao possui interface",
        );

        throwIf(
          currentConvention.inferenceType == InferenceType.multipleByInteger &&
              clazz.interfaces.isEmpty,
          "A classe ${clazz.name} identificada pela interface nao possui interface",
        );

        final typeResolver =
            getResolver(await buildStep.resolver.libraries.toList());
        final currentDependency = DependencyResolver(typeResolver);

        final interface = currentConvention.inferenceType ==
                    InferenceType.uniqueByFirstInterface ||
                currentConvention.inferenceType ==
                    InferenceType.multipleByInteger ||
                currentConvention.inferenceType ==
                    InferenceType.multipleByClassName
            ? clazz.interfaces.first.element
            : null;

        currentDependency.typeImpl = typeResolver.resolveType(clazz.thisType);
        currentDependency.type = interface != null
            ? typeResolver.resolveType(interface.thisType)
            : currentDependency.typeImpl;
        currentDependency.injectableType = currentConvention.injectableType;

        allDepsInStep.add(currentDependency.resolve(clazz));
      }
    }
    if (allDepsInStep.isEmpty) super.generate(library, buildStep);

    return allDepsInStep.isNotEmpty ? jsonEncode(allDepsInStep) : null;
  }

  bool _hasConventionalMatch(ClassElement clazz) {
    if (clazz.isAbstract) {
      return false;
    }

    final fileName = clazz.source.shortName.replaceFirst('.dart', '');
    return _classNameMatcher.hasMatch(clazz.name);
  }
}
