import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_icon.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';

import 'package:flutter/material.dart';

enum IconSearchType {
  disable,
  enable,
}

class IconSearchValues {
  const IconSearchValues({
    required this.iconHeroTag,
  });

  static const String heroTagEnable = 'icon_search';
  static const String heroTagDisable = 'icon_search_disabled';

  final String iconHeroTag;
}

const Map<IconSearchType, IconSearchValues> searchPreset =
    <IconSearchType, IconSearchValues>{
  IconSearchType.disable: IconSearchValues(
    iconHeroTag: IconSearchValues.heroTagDisable,
  ),
  IconSearchType.enable: IconSearchValues(
    iconHeroTag: IconSearchValues.heroTagEnable,
  ),
};

class IconSearchComponent extends StatelessWidget {
  IconSearchComponent({
    Key? key,
    required IconSearchType type,
    this.onTap,
  })  : preset = searchPreset[type]!,
        super(key: key);

  final IconSearchValues preset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: preset.iconHeroTag,
      child: Material(
        child: const CoreContainer(
          child: CoreIcon(
            icon: Icons.search,
            color: CoreColorType.primary,
          ),
        ),
      ),
    );
  }
}
