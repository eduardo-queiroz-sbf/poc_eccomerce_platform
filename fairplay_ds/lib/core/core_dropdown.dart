import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_icon.dart';
import 'package:fairplay_ds/core/core_text_field.dart';
import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/icon_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:fairplay_ds/theme/interfaces/text_input_theme.dart';
import 'package:flutter/material.dart';

import 'core_message.dart';

const String assetName = 'assets/images/icons/dropdown.svg';
const String assetItemName = 'assets/images/icons/dropdown_item.svg';

class CoreDropdownController {
  CoreDropdownController({this.value = ''});

  String value;
}

class CoreDropdown extends StatefulWidget {
  const CoreDropdown({
    Key? key,
    required this.itemsList,
    required this.controller,
    required this.placeholder,
    this.errorMessage,
    this.label = '',
    this.height = 30,
    this.width = double.infinity,
    this.validations,
  }) : super(key: key);

  final ValidateFunction? validations;
  final List<String> itemsList;
  final String placeholder;
  final double height;
  final double width;
  final String? errorMessage;
  final String label;
  final CoreDropdownController controller;

  @override
  State<CoreDropdown> createState() => _CoreDropdowntState();
}

class _CoreDropdowntState extends State<CoreDropdown> {
  late TextInputStateType currentState = TextInputStateType.enable;
  String? _errorMessage;

  @override
  void initState() {
    widget.itemsList.insert(0, widget.placeholder);
    super.initState();
  }

  String? _validate() {
    if (widget.validations != null) {
      final String? validation =
          widget.validations?.call(widget.controller.value);

      if (validation != '' && validation != null) {
        setState(() {
          _errorMessage = validation.toString();
          currentState = TextInputStateType.error;
        });

        return validation;
      }

      setState(() {
        _errorMessage = null;
        currentState = TextInputStateType.enable;
      });
    }
    return null;
  }

  Widget _buildError() {
    if (widget.errorMessage != null ||
        (_errorMessage != null && _errorMessage!.isNotEmpty)) {
      return CoreContainer(
        padding: CoreSpacing(
          bottom: CoreSpacingType.small,
        ),
        child: CoreMessage.error(message: widget.errorMessage ?? _errorMessage),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  VoidCallback? _focusChange(bool hasFocus) {
    if (!hasFocus && currentState == TextInputStateType.focusOrFill) {
      _validate();
    }

    setState(() {
      currentState =
          hasFocus ? TextInputStateType.focusOrFill : TextInputStateType.enable;
    });
  }

  CoreInputDecorationThemeData _getThemedStyle(BuildContext context) {
    return Theme.of(context)
            .extension<CoreInputDecorationTheme>()!
            .values[TextInputDecorationType.underline]![currentState] ??
        CoreInputDecorationThemeData.defaultInstance();
  }

  @override
  Widget build(BuildContext context) {
    CoreInputDecorationThemeData currentStyle = _getThemedStyle(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CoreContainer(
          padding: CoreSpacing(bottom: CoreSpacingType.small),
          child: Focus(
            onFocusChange: (bool focus) {
              _focusChange(focus);
            },
            child: DropdownButtonFormField<String>(
              hint: CoreContainer(
                child: CoreTypography.bodyText2Normal(
                  widget.placeholder,
                  color: CoreColorType.neutral400,
                  textAlign: TextAlign.start,
                ),
              ),
              decoration: currentStyle.inputDecoration!.copyWith(
                labelText: widget.controller.value != '' ? widget.label : null,
                labelStyle: currentStyle.animatedLabelStyle,
                enabled: currentState != TextInputStateType.disabled,
                hintText:
                    widget.controller.value != '' ? widget.placeholder : null,
                hintStyle: currentStyle.placeholderStyle,
                errorText: widget.errorMessage ?? _errorMessage,
              ),
              dropdownColor: Theme.of(context)
                  .extension<CoreColorTheme>()!
                  .values[CoreColorType.neutralWhite],
              value: widget.controller.value == ''
                  ? null
                  : widget.controller.value,
              icon: CoreIcon(
                icon: assetName,
                color: CoreColorType.primary,
                iconSize: CoreIconSizeType.medium,
              ),
              elevation: 4,
              onChanged: (String? newValue) {
                setState(() {
                  widget.controller.value = newValue!;
                });
              },
              selectedItemBuilder: (BuildContext context) {
                return widget.itemsList.map<Widget>((String item) {
                  return CoreContainer(
                    child: CoreTypography.bodyText2Normal(
                      item,
                      color: CoreColorType.neutralBlack,
                      textAlign: TextAlign.end,
                    ),
                  );
                }).toList();
              },
              items: _getItems(),
              validator: (_) => _validate(),
            ),
          ),
        ),
        _buildError()
      ],
    );
  }

  List<DropdownMenuItem<String>> _getItems() {
    return widget.itemsList.map<DropdownMenuItem<String>>((String value) {
      final String key = value == widget.placeholder ? '' : value;

      return DropdownMenuItem<String>(
        value: key,
        child: CoreContainer(
          width: double.infinity,
          padding: CoreSpacing(vertical: CoreSpacingType.medium),
          child: CoreTypography(value, color: CoreColorType.neutralBlack),
        ),
      );
    }).toList();
  }
}
