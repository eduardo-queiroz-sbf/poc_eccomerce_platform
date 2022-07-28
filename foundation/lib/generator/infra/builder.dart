import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generators/foundation_config.dart';
import 'generators/foundation_convention.dart';

Builder foundationConventionBuilder(BuilderOptions options) {
  return LibraryBuilder(
    FoundationConvention(options.config),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.injectable.json',
  );
}

Builder foundationConfigBuilder(BuilderOptions options) {
  return LibraryBuilder(
    FoundationConfig(),
    generatedExtension: '.config.dart',
  );
}
