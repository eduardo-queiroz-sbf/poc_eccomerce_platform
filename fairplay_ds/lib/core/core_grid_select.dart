import 'package:flutter/material.dart';

const double _gridSelectCrossAxisSpacing = 10.0;
const double _gridSelectMainAxisSpacing = 10.0;
const double _gridSelectButtonBorderWidth = 2.0;
const double _gridSelectButtonBorderRadius = 8.0;
const double _gridSelectButtonPadding = 8.0;

class CoreGridItem {
  CoreGridItem({
    required this.label,
    required this.value,
    this.enabled = true,
  });

  final String label;
  final dynamic value;
  final bool enabled;
}

typedef CoreGridOnSelect = void Function(CoreGridItem item);

class CoreGridController {
  CoreGridController({this.onSelect, this.value});

  dynamic value;
  CoreGridOnSelect? onSelect;
}

class CoreGridSelect extends StatefulWidget {
  const CoreGridSelect({
    Key? key,
    required this.items,
    required this.crossAxisCount,
    required this.controller,
    this.childAspectRatio = 5 / 2,
    this.height = 400,
    this.padding = 8,
    this.fontSize = 16,
  }) : super(key: key);

  final List<CoreGridItem> items;
  final int crossAxisCount;
  final CoreGridController controller;
  final double childAspectRatio;
  final double height;
  final double padding;
  final double fontSize;

  @override
  _CoreGridSelectState createState() => _CoreGridSelectState();
}

class _CoreGridSelectState extends State<CoreGridSelect> {
  bool _isSelected(CoreGridItem item) {
    return item.enabled && item.value == widget.controller.value;
  }

  void _handlePressed(CoreGridItem item) {
    if (mounted) {
      setState(() {
        widget.controller.value = item.value;
      });
    }
    widget.controller.onSelect?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: GridView.count(
        childAspectRatio: widget.childAspectRatio,
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: _gridSelectCrossAxisSpacing,
        mainAxisSpacing: _gridSelectMainAxisSpacing,
        padding: EdgeInsets.all(widget.padding),
        children: widget.items
            .map(
              (CoreGridItem item) => OutlinedButton(
                onPressed: item.enabled ? () => _handlePressed(item) : null,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black12,
                    width: _gridSelectButtonBorderWidth,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_gridSelectButtonBorderRadius),
                  ),
                  padding: const EdgeInsets.all(_gridSelectButtonPadding),
                  primary: _isSelected(item)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  backgroundColor: _isSelected(item)
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                  textStyle: TextStyle(
                    color: _isSelected(item) ? Colors.white : Colors.black,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: Text(item.label),
              ),
            )
            .toList(),
      ),
    );
  }
}
