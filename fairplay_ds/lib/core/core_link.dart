import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreLink extends StatelessWidget {
  const CoreLink({
    this.appNavigatorFactory,
    required this.label,
    required this.url,
  });

  final dynamic appNavigatorFactory;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (appNavigatorFactory == null && await canLaunch(url)) {
          await launch(url);
          return;
        }

        appNavigatorFactory?.get(context).pushNamed(url);
        return;
      },
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
