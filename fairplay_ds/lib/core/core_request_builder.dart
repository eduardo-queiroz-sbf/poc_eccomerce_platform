import 'dart:async';
import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef RequestError = Function({
  Object? error,
});
typedef RequestErrorWidget = Widget Function({
  Object? error,
  required VoidCallback reload,
});
typedef RequestReload = Widget Function({
  required VoidCallback reload,
});
typedef WidgetDoneFunction<T> = Widget Function(T value);

class RequestData<T> {
  RequestData(this.value, this.loading);
  final T value;
  final bool loading;
}

enum LoadType {
  withoutLoadOnInit,
  defaultLoad,
  loadOnlyOnInit,
}

class CoreRequestController {
  VoidCallback reload = () {};

  void setReload(VoidCallback value) => reload = value;
}

class CoreRequestBuilder<T> extends StatefulWidget {
  factory CoreRequestBuilder({
    LoadType loadType = LoadType.defaultLoad,
    required AsyncValueGetter<Either<Exception, T>> load,
    Function(VoidCallback)? listener,
    Function(VoidCallback)? removeListener,
    Widget Function()? loading,
    RequestReload? empty,
    RequestErrorWidget? error,
    RequestError? onError,
    WidgetDoneFunction<T>? done,
    AsyncWidgetBuilder? builder,
    CoreRequestController? controller,
  }) {
    assert(
      !(done == null && builder == null),
      'CoreRequestBuilder exige o parametro done ou builder para renderizar o resultado',
    );
    assert(
      !(done != null && builder != null),
      'O parametro done e builder do CoreRequestBuilder não podem ser renderizados juntos',
    );
    return CoreRequestBuilder.raw(
      load: load,
      loadType: loadType,
      listener: listener,
      removeListener: removeListener,
      loading: loading,
      empty: empty,
      error: error,
      onError: onError,
      done: done,
      builder: builder,
      controller: controller,
    );
  }
  const CoreRequestBuilder.raw({
    required this.load,
    required this.loadType,
    this.listener,
    this.removeListener,
    this.loading,
    this.empty,
    this.error,
    this.onError,
    this.done,
    this.builder,
    this.controller,
  });
  final LoadType loadType;
  final AsyncValueGetter<Either<Exception, T>> load;
  final Function(VoidCallback)? listener;
  final Function(VoidCallback)? removeListener;
  final Widget Function()? loading;
  final RequestReload? empty;
  final RequestErrorWidget? error;
  final RequestError? onError;
  final WidgetDoneFunction<T>? done;
  final AsyncWidgetBuilder? builder;
  final CoreRequestController? controller;

  @override
  State<StatefulWidget> createState() => CoreRequest<T>();
}

class CoreRequest<T> extends State<CoreRequestBuilder<T>> {
  StreamController<RequestData<T?>> _controller =
      StreamController<RequestData<T?>>();
  StreamSubscription<Either<Exception, T>>? runningRequest;
  bool firstRequest = true;

  void load() {
    if (runningRequest != null && !runningRequest!.isPaused) {
      runningRequest!.cancel();
    }

    if (_controller.isClosed) return;

    if (widget.loadType != LoadType.loadOnlyOnInit ||
        firstRequest && widget.loadType == LoadType.loadOnlyOnInit) {
      _controller.add(RequestData(null, true));
    }
    runningRequest = widget.load().asStream().listen(
      (tupleData) {
        if (mounted) {
          tupleData.fold((err) {
            _controller.addError(err);
            widget.onError?.call(error: err);
          }, (data) {
            _controller.add(RequestData<T>(data, false));
            setState(() {
              firstRequest = false;
            });
          });
          ;
        }
      },
      onError: (err) {
        if (mounted) {
          _controller.addError(err);
          widget.onError?.call(error: err);
        }
      },
    );
  }

  @override
  void initState() {
    //add listener to reload request
    if (widget.listener != null) {
      widget.listener!(load);
    } else if (widget.loadType != LoadType.withoutLoadOnInit) {
      //initial request
      load();
    }

    widget.controller?.setReload.call(load);

    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    if (widget.listener != null && widget.removeListener != null) {
      widget.removeListener!(load);
    }
    super.dispose();
  }

  Widget doneScreen(snapshot, load) {
    try {
      return widget.done!(snapshot.data!.value as T);
    } catch (e) {
      return widget.error?.call(error: snapshot.error, reload: load) ??
          SizedBox.shrink();
    }
  }

  Widget emptyScreen(snapshot, load) {
    try {
      return widget.empty?.call(reload: load) ?? SizedBox.shrink();
    } catch (e) {
      return widget.error?.call(error: snapshot.error, reload: load) ??
          SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RequestData<T?>>(
      stream: _controller.stream,
      builder: widget.builder ??
          (BuildContext context, AsyncSnapshot<RequestData<T?>> snapshot) {
            //error state
            if (snapshot.hasError) {
              return widget.error?.call(error: snapshot.error, reload: load) ??
                  SizedBox.shrink();
            }
            // make a request
            else if (snapshot.data != null) {
              // done state
              if (!snapshot.data!.loading ||
                  (!firstRequest &&
                      widget.loadType == LoadType.loadOnlyOnInit)) {
                // succesful state when list
                if (snapshot.data!.value is List) {
                  // succesful state when data is empty
                  if ((snapshot.data!.value as List).isEmpty) {
                    return emptyScreen(snapshot, load);
                  }
                  return doneScreen(snapshot, load);
                }
                // succesful state when object
                else {
                  if (snapshot.data?.value != null)
                    return doneScreen(snapshot, load);
                  else
                    return widget.empty?.call(reload: load) ??
                        SizedBox.shrink();
                }
              }
              // loading state
              else {
                return widget.loading?.call() ?? SizedBox.shrink();
              }
            }
            // without load on init state
            if (firstRequest && widget.loadType == LoadType.withoutLoadOnInit) {
              return widget.empty?.call(reload: load) ?? SizedBox.shrink();
            } else {
              return widget.loading?.call() ?? SizedBox.shrink();
            }
          },
    );
  }
}
