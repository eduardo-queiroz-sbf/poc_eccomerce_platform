import 'package:collection/collection.dart';
import 'package:foundation_generator/convention/injectable_conventions.dart';
import 'package:injectable_generator/models/dependency_config.dart';
import 'package:injectable_generator/utils.dart';

import 'core/injectable_config_generator.dart';
import 'core/dependency_config.dart';

class FoundationConfig extends CoreInjectableConfigGenerator {
  FoundationConfig()
      : super((
          List<DependencyConfig> deps,
          String currentPackage,
        ) {
          List<DependencyConfig> newDeps =
              overrideDependencies(deps, currentPackage);
          final teste = validateDuplicateDependencies(newDeps);
          print(teste);
          return teste;
        });

  static List<DependencyConfig> overrideDependencies(
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

  static List<DependencyConfig> validateDuplicateDependencies(
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
        // print(dep.typeImpl.name);
        if (dep.type.name == "FeatureSetupInterface") {
          print("sera que vai");
          print(convention != null);
        }

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
