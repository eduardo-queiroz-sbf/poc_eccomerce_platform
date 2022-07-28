import 'package:fairplay_ds/theme/interfaces/pin_code_theme.dart';
import 'package:flutter/material.dart';

typedef OnCodeEnteredCompletion = void Function(String value);
typedef OnCodeChanged = void Function(String value);

class CorePinCodeField extends StatefulWidget {
  const CorePinCodeField({
    this.showCursor = true,
    this.numberOfFields = 4,
    this.fieldWidth = 50.0,
    this.fieldHeight = 50.0,
    this.margin = const EdgeInsets.only(right: 8.0),
    this.keyboardType = TextInputType.number,
    this.borderWidth = 2.0,
    this.alignment = WrapAlignment.center,
    this.crossAxisAlignment = WrapCrossAlignment.center,
    this.onSubmit,
    this.obscureText = false,
    this.enabled = true,
    this.autoFocus = false,
    this.hasCustomInputDecoration = false,
    this.filled = false,
    this.readOnly = false,
    this.decoration,
    this.onCodeChanged,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.controller,
  });

  final bool showCursor;
  final int numberOfFields;
  final double fieldWidth;
  final double borderWidth;
  final EdgeInsetsGeometry margin;
  final TextInputType keyboardType;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;
  final OnCodeEnteredCompletion? onSubmit;
  final OnCodeEnteredCompletion? onCodeChanged;
  final bool obscureText;
  final bool enabled;
  final bool filled;
  final bool autoFocus;
  final bool readOnly;
  final bool hasCustomInputDecoration;
  final BorderRadius borderRadius;
  final InputDecoration? decoration;
  final double fieldHeight;
  final TextEditingController? controller;

  @override
  _CorePinCodeFieldState createState() => _CorePinCodeFieldState();
}

class _CorePinCodeFieldState extends State<CorePinCodeField> {
  final List<String> _verificationCode = <String>[];
  final List<FocusNode> _focusNodes = <FocusNode>[];
  final List<TextEditingController> _textControllers =
      <TextEditingController>[];
  CorePinCodeTheme? corePinCodeTheme;

  @override
  void initState() {
    for (int i = 0; i <= widget.numberOfFields - 1; i++) {
      _verificationCode.add('');
      _focusNodes.add(FocusNode());
      _textControllers.add(widget.controller ?? TextEditingController());
    }

    super.initState();
  }

  @override
  void dispose() {
    for (final TextEditingController controller in _textControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context)
        .extensions
        .values
        .whereType<CorePinCodeTheme>()
        .isNotEmpty) {
      corePinCodeTheme = Theme.of(context).extension<CorePinCodeTheme>();
    }

    return generateTextFields(context);
  }

  Widget _buildTextField({
    required BuildContext context,
    required int index,
  }) {
    return Container(
      height: widget.fieldHeight,
      width: widget.fieldWidth,
      margin: widget.margin,
      child: TextField(
        key: Key('PinCodeTextField[${index}]'),
        style: corePinCodeTheme?.value.valueStyle,
        enableInteractiveSelection: true,
        showCursor: widget.showCursor,
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.center,
        maxLength: 1,
        readOnly: widget.readOnly,
        autofocus: widget.autoFocus,
        controller: _textControllers[index],
        focusNode: _focusNodes[index],
        enabled: widget.enabled,
        decoration: widget.hasCustomInputDecoration
            ? widget.decoration
            : InputDecoration(
                counterText: '',
                filled: widget.filled,
                focusedBorder: corePinCodeTheme?.value.focusedBorder,
                border: corePinCodeTheme?.value.focusedBorder,
              ),
        obscureText: widget.obscureText,
        onTap: () {
          _textControllers[index].selection = TextSelection.fromPosition(
            TextPosition(offset: _textControllers[index].text.length),
          );
        },
        onChanged: (String value) {
          _verificationCode[index] = value;
          onCleanValue(value: value, index: index);
          onCodeChanged(verificationCode: value, index: index);
          changeFocusToNextNodeWhenValueIsEntered(
            value: value,
            indexOfTextField: index,
          );
          onSubmit(verificationCode: _verificationCode, index: index);
        },
      ),
    );
  }

  OutlineInputBorder outlineBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: widget.borderWidth,
        color: color,
      ),
      borderRadius: widget.borderRadius,
    );
  }

  UnderlineInputBorder underlineInputBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: widget.borderWidth,
      ),
    );
  }

  Widget generateTextFields(BuildContext context) {
    final List<Widget> textFields =
        List<Widget>.generate(widget.numberOfFields, (int i) {
      return _buildTextField(context: context, index: i);
    });

    return Wrap(
      crossAxisAlignment: widget.crossAxisAlignment,
      alignment: widget.alignment,
      children: textFields,
    );
  }

  void changeFocusToNextNodeWhenValueIsEntered({
    required String value,
    required int indexOfTextField,
  }) {
    if (value.isNotEmpty) {
      if (indexOfTextField + 1 != widget.numberOfFields) {
        FocusScope.of(context).requestFocus(_focusNodes[indexOfTextField + 1]);
      } else {
        _focusNodes[indexOfTextField].unfocus();
      }
    }
  }

  void onSubmit({required List<String?> verificationCode, required int index}) {
    if (index == verificationCode.length - 1) {
      if (verificationCode
          .every((String? code) => code != null && code != '')) {
        if (widget.onSubmit != null) {
          widget.onSubmit!.call(verificationCode.join());
        }
      }
    }
  }

  void onCleanValue({required String value, required int index}) {
    if (value.trim().isEmpty) {
      if (index == 0) return;

      _focusNodes[index].unfocus();
      _focusNodes[index - 1].requestFocus();
    }

    if (value.trim().isNotEmpty) {
      _focusNodes[index].unfocus();
    }
  }

  void onCodeChanged({required String verificationCode, required int index}) {
    if (widget.onCodeChanged != null) {
      widget.onCodeChanged!.call(verificationCode);
    }
  }
}
