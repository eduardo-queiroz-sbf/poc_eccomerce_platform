import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'injectable/foundation_config.dart';
import 'injectable/foundation_convention.dart';

Builder foundationInjectableBuilder(BuilderOptions options) {
  return LibraryBuilder(
    FoundationConvention(options.config),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.injectable.json',
  );
}

Builder foundationInjectableConfigBuilder(BuilderOptions options) {
  return LibraryBuilder(
    FoundationConfig(),
    generatedExtension: '.config.dart',
  );
}
