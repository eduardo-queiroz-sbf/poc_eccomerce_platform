import 'package:flutter/material.dart';

const double fontSpacing = 0;

class CoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CoreAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.elevation = 0.0,
    this.automaticallyImplyLeading = false,
    this.centerTitle,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final double elevation;
  final bool automaticallyImplyLeading;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      titleSpacing: fontSpacing,
      leading: leading,
      centerTitle: centerTitle,
      actions: actions,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }
}
