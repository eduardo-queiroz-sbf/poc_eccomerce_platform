import 'package:injectable_generator/models/dependency_config.dart';
import 'package:injectable_generator/models/dispose_function_config.dart';
import 'package:injectable_generator/models/importable_type.dart';
import 'package:injectable_generator/models/injected_dependency.dart';
import 'package:injectable_generator/models/module_config.dart';

extension DependencyConfigCopyWith on DependencyConfig {
  DependencyConfig copyWith({
    ImportableType? type,
    ImportableType? typeImpl,
    int? injectableType,
    List<InjectedDependency>? dependencies,
    String? instanceName,
    bool? signalsReady,
    List<String>? environments,
    String? constructorName,
    bool? isAsync,
    List<ImportableType>? dependsOn,
    bool? preResolve,
    ModuleConfig? moduleConfig,
    DisposeFunctionConfig? disposeFunction,
  }) {
    return DependencyConfig(
      type: type ?? this.type,
      typeImpl: typeImpl ?? this.typeImpl,
      injectableType: injectableType ?? this.injectableType,
      dependencies: dependencies ?? this.dependencies,
      instanceName: instanceName ?? this.instanceName,
      signalsReady: signalsReady ?? this.signalsReady,
      environments: environments ?? this.environments,
      constructorName: constructorName ?? this.constructorName,
      isAsync: isAsync ?? this.isAsync,
      dependsOn: dependsOn ?? this.dependsOn,
      preResolve: preResolve ?? this.preResolve,
      moduleConfig: moduleConfig ?? this.moduleConfig,
      disposeFunction: disposeFunction ?? this.disposeFunction,
    );
  }
}
