import 'package:boilerplate/foundation/context/locator.dart';
import 'package:foundation/interfaces/setup/setup_widget.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const FoundationSetup(setupLocator, const SizedBox());
  }
}
