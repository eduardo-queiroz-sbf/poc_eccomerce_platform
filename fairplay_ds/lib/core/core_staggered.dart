import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';

class CoreStaggered extends StatelessWidget {
  const CoreStaggered({
    required this.child,
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: this.child,
    );
  }
}

class CoreStaggeredList extends StatelessWidget {
  const CoreStaggeredList({
    required this.child,
    required this.index,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 300),
      child: SlideAnimation(
        verticalOffset: 44.0,
        child: FadeInAnimation(
          child: this.child,
        ),
      ),
    );
  }
}

class CoreStaggeredColumn extends StatelessWidget {
  const CoreStaggeredColumn({
    required this.children,
    Key? key,
  }) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: const Duration(milliseconds: 700),
        childAnimationBuilder: (widget) => SlideAnimation(
          horizontalOffset: MediaQuery.of(context).size.width / 2,
          child: FadeInAnimation(child: widget),
        ),
        children: this.children,
      ),
    );
  }
}

class CoreStaggeredGrid extends StatelessWidget {
  const CoreStaggeredGrid({
    Key? key,
    required this.column,
    required this.child,
    required this.index,
  }) : super(key: key);
  final Widget child;
  final int column;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: column,
      position: index,
      duration: const Duration(milliseconds: 400),
      child: ScaleAnimation(
        scale: 0.9,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
