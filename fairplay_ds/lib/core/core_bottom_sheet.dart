import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_icon.dart';
import 'package:fairplay_ds/core/core_typography.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';
import 'package:flutter/material.dart';

const double borderRadius = 16.0;
const double contentPadding = 16.0;

class CoreBottomSheet extends StatelessWidget {
  const CoreBottomSheet({
    required this.content,
    this.hasDismissButton = true,
    this.title = '',
    this.onBack,
  });

  final Widget content;
  final bool hasDismissButton;
  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
        color: Theme.of(context)
                .extension<CoreColorTheme>()!
                .values[CoreColorType.neutralWhite] ??
            Colors.white,
      ),
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _BottomSheetHeader(
              hasDismissButton: hasDismissButton,
              title: title,
              onBack: onBack,
            ),
            CoreContainer(
              padding: const CoreSpacing(
                horizontal: CoreSpacingType.medium,
                bottom: CoreSpacingType.medium,
              ),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomSheetHeader extends StatelessWidget {
  const _BottomSheetHeader({
    Key? key,
    required this.hasDismissButton,
    required this.title,
    this.onBack,
  }) : super(key: key);

  final VoidCallback? onBack;
  final bool hasDismissButton;
  final String title;

  static double dividerThickness = 2.0;
  static double dividerWidth = 100.0;

  @override
  Widget build(BuildContext context) {
    void closeModal() {
      onBack != null ? onBack!() : Navigator.pop(context);
    }

    List<Widget> _buildHeader() {
      return <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (hasDismissButton)
                CoreContainer(
                  alignment: Alignment.topRight,
                  child: CoreIcon.medium(
                    icon: Icons.close,
                    onPressed: closeModal,
                  ),
                ),
              CoreContainer(
                margin: const CoreSpacing(horizontal: CoreSpacingType.medium),
                child: CoreTypography.bodyText1(title),
              ),
            ],
          ),
        ),
      ];
    }

    return Column(
      children: <Widget>[
        CoreContainer(
          color: CoreColorType.neutral400,
          width: dividerWidth,
          height: dividerThickness,
        ),
        Flex(
          direction: Axis.horizontal,
          children: _buildHeader(),
        ),
      ],
    );
  }
}
