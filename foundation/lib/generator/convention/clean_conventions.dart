import 'package:foundation/generator/infra/injectable_types.dart';

enum InferenceType {
  uniqueByClassName,
  uniqueByFirstInterface,
  multipleByInteger,
  multipleByClassName,
}

class CleanType {
  CleanType({
    required this.path,
    required this.classPattern,
    this.injectableType = InjectableType.factory,
    this.inferenceType = InferenceType.uniqueByClassName,
  });

  final InferenceType inferenceType;
  final int injectableType;
  final String path;
  final String classPattern;
}

class CleanConventions {
  static String GENERIC_PATH = ".+";
  static List<CleanType> conventions = [
    CleanType(
      inferenceType: InferenceType.uniqueByClassName,
      injectableType: InjectableType.factory,
      path: "${GENERIC_PATH}/screens/${GENERIC_PATH}_screen.dart",
      classPattern: 'Screen\$',
    ),
    CleanType(
      inferenceType: InferenceType.multipleByInteger,
      injectableType: InjectableType.factory,
      path: '${GENERIC_PATH}/routes.dart',
      classPattern: 'Routes\$',
    ),
    CleanType(
      inferenceType: InferenceType.uniqueByFirstInterface,
      injectableType: InjectableType.factory,
      path: '${GENERIC_PATH}/theme.dart',
      classPattern: 'CustomTheme\$',
    ),
    CleanType(
      inferenceType: InferenceType.uniqueByFirstInterface,
      injectableType: InjectableType.singleton,
      path: '${GENERIC_PATH}/setup.dart',
      classPattern: 'SetupEnv\$',
    ),
    CleanType(
      inferenceType: InferenceType.multipleByInteger,
      injectableType: InjectableType.factory,
      path: '${GENERIC_PATH}/setup.dart',
      classPattern: 'Setup\$',
    ),
    CleanType(
      inferenceType: InferenceType.uniqueByFirstInterface,
      injectableType: InjectableType.singleton,
      path: '${GENERIC_PATH}/route_manager.dart',
      classPattern: 'RouteManager\$',
    ),
    CleanType(
      inferenceType: InferenceType.multipleByClassName,
      injectableType: InjectableType.factory,
      path: '${GENERIC_PATH}_use_case.dart',
      classPattern: 'UseCase\$',
    ),
    CleanType(
      inferenceType: InferenceType.uniqueByClassName,
      injectableType: InjectableType.singleton,
      path: '${GENERIC_PATH}/data_sources/${GENERIC_PATH}_data_sources.dart',
      classPattern: 'DataSource',
    ),
    CleanType(
      inferenceType: InferenceType.uniqueByFirstInterface,
      injectableType: InjectableType.singleton,
      path: '${GENERIC_PATH}/data/repositories/${GENERIC_PATH}_repository.dart',
      classPattern: 'Repository\$',
    ),
    CleanType(
      inferenceType: InferenceType.uniqueByFirstInterface,
      injectableType: InjectableType.singleton,
      path: '${GENERIC_PATH}/containers/${GENERIC_PATH}.dart',
      classPattern: 'Container\$',
    ),
    CleanType(
      inferenceType: InferenceType.uniqueByClassName,
      injectableType: InjectableType.singleton,
      path: '${GENERIC_PATH}_builder.dart',
      classPattern: 'Builder\$',
    ),
    CleanType(
      inferenceType: InferenceType.multipleByInteger,
      injectableType: InjectableType.factory,
      path: '${GENERIC_PATH}_analytics.dart',
      classPattern: 'Analytics\$',
    ),
  ];
}
