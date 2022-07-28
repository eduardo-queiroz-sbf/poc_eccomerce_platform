import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:fairplay_ds/theme/interfaces/text_input_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core_message.dart';
import './core_container.dart';
import './core_typography.dart';

typedef ValidateFunction = String? Function(String);
typedef CheckValidateFunction = bool Function(String);

class CheckValidate {
  CheckValidate({
    required this.message,
    required this.validation,
  });

  final String message;
  final CheckValidateFunction validation;
}

class CheckValidationResult {
  CheckValidationResult({
    required this.result,
    required this.icon,
  });

  bool result;
  Icon icon;
}

class CoreTextField extends StatefulWidget {
  CoreTextField.outline({
    Key? key,
    required this.controller,
    bool disabled = false,
    this.isPassword = false,
    this.label = '',
    this.placeholder = '',
    this.type = TextInputType.text,
    this.decorationType = TextInputDecorationType.outline,
    this.validateOnDemand = false,
    this.validations,
    this.checkValidations,
    this.inputFormatters,
    this.suffixIcon,
    this.suffixIconOnTap,
    this.prefixIcon,
    this.autofocus = false,
    FocusNode? focusNode,
    this.errorMessage,
    this.onTap,
    this.onFocus,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.inputFocusNode,
    this.helperText,
  })  : focusNode = focusNode ?? FocusNode(),
        currentState =
            disabled ? TextInputStateType.disabled : TextInputStateType.enable,
        super(key: key);

  CoreTextField.underline({
    Key? key,
    required this.controller,
    bool disabled = false,
    this.isPassword = false,
    this.label = '',
    this.placeholder = '',
    this.type = TextInputType.text,
    this.decorationType = TextInputDecorationType.underline,
    this.validateOnDemand = false,
    this.validations,
    this.checkValidations,
    this.inputFormatters,
    this.suffixIcon,
    this.suffixIconOnTap,
    this.prefixIcon,
    this.autofocus = false,
    this.focusNode,
    this.errorMessage,
    this.onTap,
    this.onFocus,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.inputFocusNode,
    this.helperText,
  })  : currentState =
            disabled ? TextInputStateType.disabled : TextInputStateType.enable,
        super(key: key);
  final FocusNode? focusNode;
  final TextInputStateType currentState;
  final TextEditingController controller;
  final bool isPassword;
  final String label;
  final String placeholder;
  final TextInputType type;
  final TextInputDecorationType decorationType;
  final bool validateOnDemand;
  final ValidateFunction? validations;
  final List<CheckValidate>? checkValidations;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autofocus;
  final String? errorMessage;
  final VoidCallback? onTap;
  final VoidCallback? suffixIconOnTap;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? inputFocusNode;
  final String? helperText;

  final Future<void> Function(String)? onChanged;
  final void Function(bool)? onFocus;

  @override
  _CoreTextFieldState createState() => _CoreTextFieldState();
}

class _CoreTextFieldState extends State<CoreTextField> {
  late TextInputStateType currentState;

  String? _errorMessage;
  Map<int, bool> checkValidationsResult = {};

  @override
  void initState() {
    widget.controller.addListener(_handleTextFieldChanges);
    currentState = widget.currentState;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleTextFieldChanges([String? textFieldValue]) async {
    if (widget.validateOnDemand ||
        (textFieldValue == null && widget.controller.text.isNotEmpty)) {
      _validateTextField();
    }

    if (widget.onChanged != null) {
      await widget.onChanged!(textFieldValue ?? widget.controller.text);
    }

    _checkValidateTextField();
  }

  void _checkValidateTextField() {
    if (widget.checkValidations == null) return;

    for (int i = 0; i < widget.checkValidations!.length; i++) {
      checkValidationsResult[i] =
          widget.checkValidations![i].validation(widget.controller.text);
    }

    setState(() {});
  }

  String? _validateTextField() {
    if (widget.validations != null) {
      final String? validation =
          widget.validations?.call(widget.controller.text);

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

    if (widget.checkValidations != null) {
      if (checkValidationsResult.containsValue(false)) {
        return '';
      }
    }

    return null;
  }

  VoidCallback? _focusChange(bool hasFocus) {
    if (!hasFocus && currentState == TextInputStateType.focusOrFill) {
      _validateTextField();
    }

    setState(() {
      currentState = hasFocus && widget.onTap == null
          ? TextInputStateType.focusOrFill
          : TextInputStateType.enable;
    });
  }

  CoreInputDecorationThemeData _getThemedStyle(BuildContext context) {
    return Theme.of(context)
            .extension<CoreInputDecorationTheme>()!
            .values[widget.decorationType]![currentState] ??
        CoreInputDecorationThemeData.defaultInstance();
  }

  Widget _getFeedbackMessage(CoreInputDecorationThemeData currentStyle) {
    if (widget.errorMessage != null ||
        (_errorMessage != null && _errorMessage!.isNotEmpty)) {
      return CoreContainer(
        padding: CoreSpacing(
          bottom: CoreSpacingType.small,
        ),
        child: CoreMessage.error(
          message: widget.errorMessage ?? _errorMessage,
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  // Widget _buildCheckValidations(CoreInputDecorationThemeData currentStyle) {
  //   return Column(
  //     children: [
  //       for (int i = 0; i < widget.checkValidations!.length; i++)
  //         CoreContainer(
  //           margin: CoreSpacing(bottom: CoreSpacingType.tiny),
  //           child: Row(
  //             children: [
  //               if (checkValidationsResult[i] == null)
  //                 Icon(
  //                   Icons.check,
  //                   size: 20,
  //                   color: currentStyle.checkValidator?.iconIdleColor,
  //                 )
  //               else
  //                 checkValidationsResult[i]!
  //                     ? Icon(
  //                         Icons.check,
  //                         size: 20,
  //                         color: currentStyle.checkValidator?.iconSuccessColor,
  //                       )
  //                     : Icon(
  //                         Icons.close,
  //                         size: 20,
  //                         color: currentStyle.checkValidator?.iconErrorColor,
  //                       ),
  //               CoreContainer(
  //                 margin: CoreSpacing(left: CoreSpacingType.tiny),
  //                 child: Text(widget.checkValidations![i].message),
  //               ),
  //             ],
  //           ),
  //         ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    CoreInputDecorationThemeData currentStyle = _getThemedStyle(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CoreContainer(
          visible: widget.label != '' &&
              widget.decorationType == TextInputDecorationType.outline,
          padding: CoreSpacing(bottom: CoreSpacingType.small),
          child: CoreTypography(
            widget.label,
            textStyle: currentStyle.labelStyle,
          ),
        ),
        CoreContainer(
          padding: CoreSpacing(bottom: CoreSpacingType.small),
          child: Stack(
            children: [
              Focus(
                onFocusChange: (bool focus) {
                  widget.onFocus?.call(focus);
                  _focusChange(focus);
                },
                focusNode: widget.onTap == null ? widget.focusNode : null,
                child: TextFormField(
                  focusNode: widget.inputFocusNode,
                  onChanged: _handleTextFieldChanges,
                  autofocus: widget.autofocus,
                  readOnly: widget.onTap != null,
                  textInputAction: widget.textInputAction,
                  onFieldSubmitted: widget.onSubmitted,
                  controller: widget.controller,
                  inputFormatters: widget.inputFormatters,
                  style: currentStyle.fieldStyle,
                  decoration: currentStyle.inputDecoration!.copyWith(
                    labelText: widget.decorationType ==
                                TextInputDecorationType.underline &&
                            (currentState == TextInputStateType.focusOrFill ||
                                widget.controller.text != '')
                        ? widget.label
                        : null,
                    labelStyle: currentStyle.animatedLabelStyle,
                    enabled: currentState != TextInputStateType.disabled,
                    hintText: widget.placeholder,
                    hintStyle: currentStyle.placeholderStyle,
                    prefixIcon: widget.prefixIcon,
                    errorText: widget.errorMessage ?? _errorMessage,
                  ),
                  onTap: widget.onTap,
                  keyboardType: widget.type,
                  obscureText: widget.isPassword,
                  validator: (_) => _validateTextField(),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: widget.suffixIconOnTap,
                  child: CoreContainer(
                    height: widget.decorationType ==
                            TextInputDecorationType.underline
                        ? 30
                        : 40,
                    padding: CoreSpacing(horizontal: CoreSpacingType.small),
                    child: widget.suffixIcon ?? SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ),
        ),
        _getFeedbackMessage(currentStyle),
        if (widget.helperText != null)
          CoreContainer(
            margin: CoreSpacing(
              top: CoreSpacingType.tiny,
              bottom: CoreSpacingType.small,
            ),
            child: Text(widget.helperText!),
          ),
        // if (widget.checkValidations != null)
        //   _buildCheckValidations(currentStyle),
      ],
    );
  }
}
