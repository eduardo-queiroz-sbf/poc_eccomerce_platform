import 'package:flutter/material.dart';

class CoreAvatar extends StatelessWidget {
  const CoreAvatar({
    required this.image,
    this.width = 64.0,
    this.height = 64.0,
  });

  final Widget image;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipOval(
        child: image,
      ),
    );
  }
}
