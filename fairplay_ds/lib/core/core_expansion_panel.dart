import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class CoreExpansionPanelItemValue {
  CoreExpansionPanelItemValue({
    required this.title,
    required this.body,
    required this.defaultValue,
    this.onExpansionChanged,
  });

  final Widget title;
  final Widget body;
  final bool defaultValue;
  void Function(bool)? onExpansionChanged;
}

class CoreExpansionListPanel extends StatelessWidget {
  const CoreExpansionListPanel(
    this.values, {
    this.physics = const AlwaysScrollableScrollPhysics(),
    Key? key,
  }) : super(key: key);

  final List<CoreExpansionPanelItemValue> values;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: physics,
      shrinkWrap: true,
      children: values.map(
        (item) {
          return ExpansionTile(
            onExpansionChanged: item.onExpansionChanged,
            tilePadding: EdgeInsets.zero,
            initiallyExpanded: values
                .where((e) => e.title == item.title && item.defaultValue)
                .isNotEmpty,
            title: item.title,
            children: [item.body],
            iconColor: Theme.of(context)
                .extension<CoreColorTheme>()!
                .values[CoreColorType.primary],
          );
        },
      ).toList(),
    );
  }
}
