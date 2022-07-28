import 'dart:async';

import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_icon.dart';
import 'package:fairplay_ds/core/core_request_builder.dart';
import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/core/core_warning.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:flutter/material.dart';
import 'core_progress_indicator.dart';

typedef LoadPaginationType<T> = Future<Pagination<T>> Function(int, int);

class Pagination<T> {
  Pagination({
    required this.items,
    required this.total,
  });

  factory Pagination.empty() {
    return Pagination<T>(items: <T>[], total: 0);
  }

  final List<T> items;
  final int total;
}

class CoreInfiniteScroll<T> extends StatefulWidget {
  factory CoreInfiniteScroll({
    Key? key,
    required LoadPaginationType<T> load,
    required WidgetDoneFunction<T> pageItem,
    StreamController? refreshLoad,
    ScrollController? scrollController,
    RequestReload? emptyWidget,
    Widget Function()? initLoader,
    Widget Function()? pageLoader,
    RequestErrorWidget? initError,
    RequestErrorWidget? pageError,
    crossAxisCount = 1,
  }) {
    RequestErrorWidget defaultInitError =
        ({Object? error, required VoidCallback reload}) => CoreWarning.error(
              onPress: reload,
            );

    RequestReload defaultEmptyWidget =
        ({required VoidCallback reload}) => CoreWarning.empty(
              onPress: reload,
            );

    Widget Function() defaultInitLoader = () => CoreContainer.small(
          width: double.infinity,
          height: 500,
          alignment: Alignment.center,
          child: CoreProgressIndicator.large(),
        );

    Widget Function() defaultPageLoader = () => CoreContainer.small(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: CoreProgressIndicator.medium(),
        );

    RequestErrorWidget defaultPageError =
        ({Object? error, required VoidCallback reload}) => InkWell(
              onTap: reload,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CoreTypography.caption(
                    'Tentar novamente',
                    color: CoreColorType.primary,
                  ),
                  CoreContainer.small(),
                  CoreIcon.medium(
                    icon: Icons.replay_outlined,
                    color: CoreColorType.primary,
                  ),
                ],
              ),
            );

    return CoreInfiniteScroll.raw(
      key: key,
      load: load,
      refreshLoad: refreshLoad ?? StreamController(),
      crossAxisCount: crossAxisCount,
      scrollController: scrollController ?? ScrollController(),
      hasActiveScroll: scrollController == null,
      pageItem: pageItem,
      emptyWidget: emptyWidget ?? defaultEmptyWidget,
      initLoader: initLoader ?? defaultInitLoader,
      pageLoader: pageLoader ?? defaultPageLoader,
      initError: initError ?? defaultInitError,
      pageError: pageError ?? defaultPageError,
    );
  }

  const CoreInfiniteScroll.raw({
    Key? key,
    required this.scrollController,
    required this.load,
    required this.refreshLoad,
    required this.pageItem,
    required this.emptyWidget,
    required this.initLoader,
    required this.pageLoader,
    required this.initError,
    required this.pageError,
    required this.crossAxisCount,
    required this.hasActiveScroll,
  }) : super(key: key);

  final LoadPaginationType<T> load;
  final StreamController refreshLoad;
  final ScrollController scrollController;
  final bool hasActiveScroll;

  final WidgetDoneFunction<T> pageItem;
  final RequestReload emptyWidget;
  final Widget Function() initLoader;
  final Widget Function() pageLoader;
  final RequestErrorWidget initError;
  final RequestErrorWidget pageError;

  final int crossAxisCount;

  @override
  State<StatefulWidget> createState() => InfiniteScroll<T>();
}

class InfiniteScroll<T> extends State<CoreInfiniteScroll<T>> {
  final int _loadingZoneSize = 100;
  List<T> items = [];
  int total = 0;
  int countItems = 0;
  int currentPage = 0;
  bool hasError = false;
  bool isLoading = true;

  void _scrollListener() {
    if (widget.scrollController.offset >=
            widget.scrollController.position.maxScrollExtent -
                _loadingZoneSize &&
        !widget.scrollController.position.outOfRange) {
      if (!isLoading) {
        loadData();
      }
    }
  }

  void _refreshLoadListener(_) {
    widget.scrollController.removeListener(_scrollListener);
    setState(() {
      items = [];
      total = 0;
      countItems = 0;
      currentPage = 0;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
      widget.scrollController.addListener(_scrollListener);
    });
  }

  @override
  void initState() {
    widget.scrollController.addListener(_scrollListener);
    widget.refreshLoad.stream.listen(_refreshLoadListener);
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.hasActiveScroll) widget.scrollController.dispose();
  }

  void loadData() async {
    if ((total == 0 || total > countItems) && mounted) {
      try {
        setState(() {
          isLoading = true;
          hasError = false;
        });

        Pagination<T> page = await widget.load(currentPage + 1, countItems);

        setState(() {
          total = page.total;
          countItems = countItems + page.items.length;
          currentPage = currentPage + 1;
          items = [...items, ...page.items];
          isLoading = false;
          hasError = false;
        });
      } catch (e) {
        setState(() {
          hasError = true;
          isLoading = false;
        });
        return;
      }

      if ((widget.scrollController.positions.length == 0) &&
          (total > countItems)) {
        loadData();
      }
    }
  }

  Widget listView() {
    return ListView.builder(
      primary: widget.hasActiveScroll ? null : false,
      shrinkWrap: true,
      itemCount: (countItems / widget.crossAxisCount).round(),
      itemBuilder: (_, int index) {
        List<Widget> rowItems = [];
        for (var i = index * widget.crossAxisCount;
            i < (index * widget.crossAxisCount) + widget.crossAxisCount &&
                countItems > i;
            i++) {
          rowItems.add(widget.pageItem(items[i]));
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowItems,
        );
      },
      controller: widget.hasActiveScroll ? widget.scrollController : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Visibility(
          visible: countItems == 0 && !isLoading && !hasError,
          child: widget.emptyWidget(reload: loadData),
        ),
        Visibility(
          visible: total > 0,
          child:
              widget.hasActiveScroll ? Expanded(child: listView()) : listView(),
        ),
        Visibility(
          visible: countItems == 0 && isLoading,
          child: widget.initLoader(),
        ),
        Visibility(
          visible: countItems == 0 && hasError,
          child: widget.initError(reload: loadData),
        ),
        Visibility(
          visible: countItems != 0 && isLoading,
          child: widget.pageLoader(),
        ),
        Visibility(
          visible: countItems != 0 && hasError,
          child: widget.pageError(reload: loadData),
        ),
      ],
    );
  }
}
