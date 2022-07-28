import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:flutter/material.dart';
import 'core_message.dart';

class CoreCheckboxController {
  CoreCheckboxController({this.value = false});

  bool value;
}

class CoreCheckbox extends StatefulWidget {
  const CoreCheckbox({
    Key? key,
    required this.content,
    required this.controller,
    this.onChange,
    this.error = '',
    this.label = '',
  }) : super(key: key);

  final Widget content;
  final CoreCheckboxController controller;
  final String error;
  final String label;
  final Function(bool?)? onChange;

  @override
  _CoreCheckboxState createState() => _CoreCheckboxState();
}

class _CoreCheckboxState extends State<CoreCheckbox> {
  static double checkboxBorderWidth = 1.5;
  static double checkboxBorderRadius = 4.0;
  static double checkboxLeftMargin = 0.0;
  static double checkboxRightMargin = 8.0;
  static double checkboxVerticalMargin = 16.0;
  static double checkboxSize = 18.0;
  static double checkboxSplashRadius = 16.0;

  Widget _buildError() {
    if (widget.error == '') {
      return Container();
    }
    return CoreMessage.error(message: widget.error);
  }

  Widget _buildLabel() {
    if (widget.label == '') {
      return Container();
    }

    return Text(
      widget.label,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CoreColorTheme>()!.values;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildLabel(),
        Row(
          children: <Widget>[
            Container(
              height: checkboxSize,
              width: checkboxSize,
              margin: EdgeInsets.fromLTRB(
                checkboxLeftMargin,
                checkboxVerticalMargin,
                checkboxRightMargin,
                checkboxVerticalMargin,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(checkboxBorderRadius),
                border: Border.all(
                  width: 1.5,
                  color: colorTheme[CoreColorType.neutral500] ?? Colors.white,
                ),
              ),
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.transparent,
                ),
                child: Checkbox(
                  activeColor: colorTheme[CoreColorType.primary],
                  checkColor:
                      colorTheme[CoreColorType.neutralWhite] ?? Colors.white,
                  value: widget.controller.value,
                  onChanged: (value) {
                    widget.onChange?.call(value);
                    setState(() {
                      widget.controller.value = !widget.controller.value;
                    });
                  },
                ),
              ),
            ),
            Flexible(
              child: InkWell(
                  child: widget.content,
                  onTap: () {
                    widget.onChange?.call(!widget.controller.value);
                    setState(() {
                      widget.controller.value = !widget.controller.value;
                    });
                  }),
            )
          ],
        ),
        _buildError(),
      ],
    );
  }
}
