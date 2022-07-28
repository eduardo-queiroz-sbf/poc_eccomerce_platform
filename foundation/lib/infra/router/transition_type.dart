import 'package:flutter/material.dart';

import '../constants/animation.dart';

enum CorePageTransitionType {
  /// Fade Animation
  fade,

  /// Right to left animation
  rightToLeft,

  /// Left to right animation
  leftToRight,

  /// Right to left with fading animation
  rightToLeftWithFade,

  /// Left to right with fading animation
  leftToRightWithFade,
}

/// Page transition class compose for PageRouteBuilder
class CorePageTransition<T> {
  /// Page transition constructor. We can pass the next page as a child,
  const CorePageTransition({
    required this.type,
    this.context,
    this.inheritTheme = false,
    this.curve = Curves.linear,
    this.alignment,
    this.duration = kAnimationRoute,
    this.reverseDuration = kAnimationRoute,
    this.fullscreenDialog = false,
    this.opaque = false,
  });

  /// Transition types
  final CorePageTransitionType type;

  /// Curves for transitions
  final Curve curve;

  /// Alignment for transitions
  final Alignment? alignment;

  /// Duration for your transition default is 300 ms
  final Duration duration;

  /// Duration for your pop transition default is 300 ms
  final Duration reverseDuration;

  /// Context for inherit theme
  final BuildContext? context;

  /// Optional inherit theme
  final bool inheritTheme;

  /// Optional fullscreen dialog mode
  final bool fullscreenDialog;

  final bool opaque;

  PageRouteBuilder<T> provider(
    Widget child,
    RouteSettings? settings,
  ) =>
      PageRouteBuilder<T>(
        settings: settings,
        pageBuilder: (
          _,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
            inheritTheme
                ? InheritedTheme.captureAll(
                    context!,
                    child,
                  )
                : child,
        transitionDuration: duration,
        reverseTransitionDuration: reverseDuration,
        opaque: opaque,
        fullscreenDialog: fullscreenDialog,
        transitionsBuilder: (
          _,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          switch (type) {
            case CorePageTransitionType.fade:
              return FadeTransition(opacity: animation, child: child);
              // ignore: dead_code
              break;

            case CorePageTransitionType.rightToLeft:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
              // ignore: dead_code
              break;

            case CorePageTransitionType.leftToRight:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
              // ignore: dead_code
              break;

            case CorePageTransitionType.rightToLeftWithFade:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
              );
              // ignore: dead_code
              break;

            case CorePageTransitionType.leftToRightWithFade:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: curve,
                  ),
                ),
                child: FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
              );
              // ignore: dead_code
              break;

            default:
              return FadeTransition(opacity: animation, child: child);
          }
        },
      );
}
