import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/material.dart';
import 'core_expansion_panel.dart';
import 'core_message.dart';

class CoreRadioButtonItem {
  CoreRadioButtonItem({
    this.label = '',
    this.value,
  });
  String label;
  dynamic value;
}

class CoreRadioButtonController {
  CoreRadioButtonController({
    this.value,
  });
  dynamic value;
}

enum CoreRadioButtonDirection { column, row }

class CoreRadioButton extends StatefulWidget {
  const CoreRadioButton.row({
    Key? key,
    required this.buildItem,
    required this.controller,
    this.direction = CoreRadioButtonDirection.row,
    this.initialValue = '',
    this.error = '',
    this.label = '',
    required this.items,
    this.onChange,
    this.toggleable = true,
  }) : super(key: key);

  const CoreRadioButton.column({
    Key? key,
    required this.buildItem,
    required this.controller,
    this.direction = CoreRadioButtonDirection.column,
    this.initialValue = '',
    this.error = '',
    this.label = '',
    required this.items,
    this.onChange,
    this.toggleable = true,
  }) : super(key: key);

  final Widget Function(CoreRadioButtonItem) buildItem;
  final CoreRadioButtonController controller;
  final CoreRadioButtonDirection direction;
  final String initialValue;
  final String error;
  final String label;
  final List<CoreRadioButtonItem> items;
  final bool toggleable;
  final Function(dynamic)? onChange;

  @override
  State<CoreRadioButton> createState() => _CoreRadioButtonState();
}

class _CoreRadioButtonState extends State<CoreRadioButton> {
  static double radioIconSize = 20.0;
  @override
  void initState() {
    if (widget.initialValue != '') {
      widget.controller.value = widget.initialValue;
    }
    super.initState();
  }

  Widget _buildRadioButton(CoreRadioButtonItem item) {
    void _setRadioButtonValue(_) {
      if (widget.toggleable) {
        setState(() {
          widget.controller.value = item.value;
        });
      }
      widget.onChange?.call(item.value);
    }

    return CoreContainer(
      margin: CoreSpacing(
        bottom: CoreSpacingType.medium,
      ),
      child: InkWell(
        onTap: () => _setRadioButtonValue(''),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CoreContainer(
              height: radioIconSize,
              width: radioIconSize,
              child: Radio<String>(
                key: Key(item.label),
                activeColor: Theme.of(context)
                        .extension<CoreColorTheme>()!
                        .values[CoreColorType.primary] ??
                    Colors.black,
                value: widget.controller.value.toString(),
                groupValue: item.value.toString(),
                onChanged: _setRadioButtonValue,
              ),
            ),
            Expanded(
              child: CoreContainer(
                margin: CoreSpacing(
                  horizontal: CoreSpacingType.small,
                ),
                child: widget.buildItem(item),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CoreContainer(
            visible: widget.label.isNotEmpty,
            child: CoreTypography.bodyText1(
              widget.label,
            ),
          ),
          if (widget.direction == CoreRadioButtonDirection.row)
            CoreExpansionListPanel(
              widget.items.map(
                (CoreRadioButtonItem item) {
                  return CoreExpansionPanelItemValue(
                    defaultValue: false,
                    title: CoreTypography.bodyText2Normal(''),
                    body: _buildRadioButton(item),
                  );
                },
              ).toList(),
            )
          else
            Column(
              children: widget.items.map((CoreRadioButtonItem item) {
                return _buildRadioButton(item);
              }).toList(),
            ),
          CoreContainer(
            visible: widget.error.isNotEmpty,
            padding: CoreSpacing(
              horizontal: CoreSpacingType.medium,
              vertical: CoreSpacingType.small,
            ),
            child: CoreMessage.error(message: widget.error),
          ),
        ],
      ),
    );
  }
}
