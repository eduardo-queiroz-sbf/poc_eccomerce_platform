import 'package:flutter/material.dart';

class CoreTabs extends StatefulWidget {
  const CoreTabs({
    Key? key,
    required this.tabs,
    required this.tabViews,
    this.actionButtons = const <IconButton>[],
    this.onTap,
  }) : super(key: key);

  final List<Tab> tabs;
  final List<Widget> tabViews;
  final List<IconButton> actionButtons;
  final void Function(int)? onTap;

  @override
  _CoreTabsState createState() => _CoreTabsState();
}

class _CoreTabsState extends State<CoreTabs> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          toolbarHeight: 48.0,
          title: TabBar(
            indicatorColor: Theme.of(context).colorScheme.secondary,
            tabs: widget.tabs,
            onTap: widget.onTap,
          ),
          actions: widget.actionButtons,
        ),
        body: TabBarView(
          children: widget.tabViews,
        ),
      ),
    );
  }
}
