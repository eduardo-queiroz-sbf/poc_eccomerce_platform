import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_icon.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/icon_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:fairplay_ds/theme/interfaces/step_theme.dart';
import 'package:foundation/infra/util/extensions.dart';
import 'package:flutter/material.dart';

enum CoreStepDirectionType {
  vertical,
}

class CoreStepData {
  CoreStepData({
    required this.title,
    required this.label,
    this.type = CoreStepType.disabled,
  });

  final String title;
  final String label;
  final CoreStepType type;
}

class CoreStep extends StatelessWidget {
  const CoreStep({
    required this.data,
    this.directiontype = CoreStepDirectionType.vertical,
  });
  final CoreStepDirectionType directiontype;
  final List<CoreStepData> data;

  @override
  Widget build(BuildContext context) {
    if (directiontype == CoreStepDirectionType.vertical) {
      return Column(
        children: data
            .mapIndexed(
              (item, index) => CoreStepItem(
                data: item,
                // withLine: !(data.length == index + 1),
                theme: Theme.of(context)
                    .extension<CoreStepTheme>()!
                    .values[item.type]!,
                nextLineColor: !(data.length == index + 1)
                    ? Theme.of(context)
                        .extension<CoreStepTheme>()!
                        .values[data[index + 1].type]!
                        .colorLine
                    : null,
              ),
            )
            .toList(),
      );
    } else {
      throw UnimplementedError();
    }
  }
}

class CoreStepItem extends StatelessWidget {
  const CoreStepItem({
    required this.data,
    // required this.withLine,
    required this.theme,
    required this.nextLineColor,
  });
  final CoreStepThemeData theme;
  final CoreStepData data;
  // final bool withLine;
  final CoreColorType? nextLineColor;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CoreContainer(
                color: theme.color,
                margin: CoreSpacing(all: CoreSpacingType.tiny),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CoreIcon(
                  icon: theme.path,
                  color: CoreColorType.neutralWhite,
                  iconSize: CoreIconSizeType.small,
                ),
              ),
              Expanded(
                child: CoreContainer(
                  visible: nextLineColor != null,
                  color: nextLineColor,
                  width: 1.5,
                  constraints: BoxConstraints.tightFor(height: 35),
                  radius: true,
                ),
              ),
            ],
          ),
          Expanded(
            child: CoreContainer(
              margin: CoreSpacing(
                left: CoreSpacingType.small,
                top: CoreSpacingType.small,
                bottom: CoreSpacingType.medium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CoreContainer(
                    margin: CoreSpacing(
                      bottom: CoreSpacingType.small,
                    ),
                    child: Text(
                      data.title,
                      style: theme.titleStyle,
                    ),
                  ),
                  Text(
                    data.label,
                    style: theme.labelStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
