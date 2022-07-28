import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef FutureError = Widget Function({
  Object? error,
});

typedef WidgetDoneFunction<T> = Widget Function(T value);

class CoreFutureBuilder<T> extends StatefulWidget {
  const CoreFutureBuilder({
    required this.load,
    this.loading,
    this.error,
    this.done,
    this.builder,
  }) : assert(
          !(done == null && builder == null),
          'CoreFutureBuilder exige o parametro done ou builder para renderizar o resultado',
        );

  final AsyncValueGetter<T> load;
  final Widget? loading;
  final FutureError? error;
  final WidgetDoneFunction<T>? done;
  final AsyncWidgetBuilder? builder;

  @override
  State<StatefulWidget> createState() => CoreFuture<T>();
}

class CoreFuture<T> extends State<CoreFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.load(),
      builder: widget.builder ??
          (BuildContext context, AsyncSnapshot<T> snapshot) {
            // verify if asyncronous method has throw a error
            if (snapshot.hasError && widget.error != null) {
              return widget.error!(error: snapshot.error);
            }

            // verify if asyncronous method has return a value and if has a empty widget verify the lenght of value
            else if (snapshot.connectionState == ConnectionState.done) {
              return widget.done!(snapshot.data as T);
            }

            // verify if asyncronous method is waiting
            else if (snapshot.connectionState == ConnectionState.waiting &&
                widget.loading != null) {
              return widget.loading!;
            }

            // unknown asyncronous state
            // todo: log on crashlitics
            return const SizedBox.shrink();
          },
    );
  }
}
