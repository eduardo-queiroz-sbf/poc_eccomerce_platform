import 'package:fairplay_ds/core/core_progress_indicator.dart';
import 'package:fairplay_ds/core/core_request_builder.dart';
import 'package:fairplay_ds/theme/interfaces/progress_indicator_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum CoreInkWellStateType { disabled, normal, loader }

mixin SharedInkWellLogic<T extends StatefulWidget> on State<T> {
  CoreInkWellStateType currentState = CoreInkWellStateType.normal;

  AsyncCallback? onTap(AsyncCallback? onTap, RequestError? onError) {
    if (currentState != CoreInkWellStateType.normal || onTap == null) {
      return null;
    } else {
      return () async {
        try {
          setState(() {
            currentState = CoreInkWellStateType.loader;
          });

          await onTap();
        } catch (e) {
          onError?.call(error: e);
        } finally {
          setState(() {
            currentState = CoreInkWellStateType.normal;
          });
        }
      };
    }
  }
}

class CoreInkWell extends StatefulWidget {
  factory CoreInkWell({
    Key? key,
    required Widget content,
    AsyncCallback? onTap,
    RequestError? onError,
    Widget? contentLoading,
    CoreProgressIndicatorType? progressIndicatorType,
  }) {
    const CoreProgressIndicatorType indicatorType =
        CoreProgressIndicatorType.medium;

    final Widget defaultContentLoading = Center(
      child: CoreProgressIndicator(
        type: progressIndicatorType ?? indicatorType,
      ),
    );

    return CoreInkWell.raw(
      key: key,
      content: content,
      contentLoading: contentLoading ?? defaultContentLoading,
      onTap: onTap,
      onError: onError,
      progressIndicatorType: progressIndicatorType ?? indicatorType,
    );
  }

  const CoreInkWell.raw({
    Key? key,
    required this.contentLoading,
    required this.content,
    required this.progressIndicatorType,
    this.onTap,
    this.onError,
  }) : super(key: key);

  final Widget contentLoading;
  final Widget content;
  final AsyncCallback? onTap;
  final RequestError? onError;
  final CoreProgressIndicatorType progressIndicatorType;

  @override
  State<CoreInkWell> createState() => _CoreInkWellState();
}

class _CoreInkWellState extends State<CoreInkWell>
    with SharedInkWellLogic<CoreInkWell> {
  @override
  Widget build(BuildContext context) {
    if (currentState == CoreInkWellStateType.loader) {
      return widget.contentLoading;
    }

    return InkWell(
      onTap: onTap(widget.onTap, widget.onError),
      child: widget.content,
    );
  }
}
