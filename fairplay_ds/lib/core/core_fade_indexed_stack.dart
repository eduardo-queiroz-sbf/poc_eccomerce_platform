import 'package:flutter/widgets.dart';

const int animationDuration = 800;
const double initialOpacity = 0.7;

class CoreFadeIndexedStack extends StatefulWidget {
  const CoreFadeIndexedStack({
    Key? key,
    required this.index,
    required this.children,
    this.duration = const Duration(
      milliseconds: animationDuration,
    ),
  }) : super(key: key);

  final int index;
  final List<Widget> children;
  final Duration duration;

  @override
  _CoreFadeIndexedStackState createState() => _CoreFadeIndexedStackState();
}

class _CoreFadeIndexedStackState extends State<CoreFadeIndexedStack> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: widget.duration);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CoreFadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _animationController.forward(from: initialOpacity);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: IndexedStack(
        index: widget.index,
        children: widget.children,
      ),
    );
  }
}
