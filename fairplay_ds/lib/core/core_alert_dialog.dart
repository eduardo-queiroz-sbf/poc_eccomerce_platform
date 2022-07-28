import 'package:flutter/material.dart';

const double titlePaddingLeft = 20;
const double titlePaddingTop = 5;
const double titlePaddingRight = 5;
const double titlePaddingBottom = 0;

const double contentPaddingLeft = 20;
const double contentPaddingTop = 0;
const double contentPaddingRight = 20;
const double contentPaddingBottom = 20;

const double borderRadius = 15;

class CoreAlertDialog extends StatelessWidget {
  const CoreAlertDialog({
    Key? key,
    this.title,
    required this.content,
    this.actions,
  }) : super(key: key);

  final Widget? title;
  final Widget content;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitle(context),
      content: content,
      actions: actions,
      titlePadding: const EdgeInsets.fromLTRB(
        titlePaddingLeft,
        titlePaddingTop,
        titlePaddingRight,
        titlePaddingBottom,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        contentPaddingLeft,
        contentPaddingTop,
        contentPaddingRight,
        contentPaddingBottom,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: title,
        ),
        IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
