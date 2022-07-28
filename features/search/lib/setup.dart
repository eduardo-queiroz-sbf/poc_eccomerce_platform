import 'package:foundation/interfaces/setup/feature_setup_interface.dart';

class Setup implements FeatureSetupInterface {
  Future<void> setup() async {
    print("setup search");
  }
}
