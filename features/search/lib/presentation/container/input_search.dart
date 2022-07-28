import './icon_search.dart';
import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_icon.dart';
import 'package:fairplay_ds/core/core_text_field.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';

import 'package:flutter/material.dart';

const String placeholderText = 'O que está procurando?';

enum SearchInputType {
  tap,
  disable,
  enable,
}

class SearchValues {
  const SearchValues({
    required this.inputHeroTag,
    required this.iconHeroTag,
  });

  static const String heroTagEnable = 'search_input';
  static const String heroTagDisable = 'search_input_disabled';

  final String inputHeroTag;
  final IconSearchType iconHeroTag;
}

const Map<SearchInputType, SearchValues> searchPreset =
    <SearchInputType, SearchValues>{
  SearchInputType.disable: SearchValues(
    inputHeroTag: SearchValues.heroTagDisable,
    iconHeroTag: IconSearchType.disable,
  ),
  SearchInputType.tap: SearchValues(
    inputHeroTag: SearchValues.heroTagEnable,
    iconHeroTag: IconSearchType.enable,
  ),
  SearchInputType.enable: SearchValues(
    inputHeroTag: SearchValues.heroTagEnable,
    iconHeroTag: IconSearchType.enable,
  ),
};

class InputSearchComponent extends StatelessWidget {
  InputSearchComponent({
    Key? key,
    required this.type,
    this.goToSearchResult,
    TextEditingController? controller,
    this.inputFocus,
    this.onTap,
  })  : preset = searchPreset[type]!,
        controller = controller ?? TextEditingController(),
        super(key: key);

  final FocusNode? inputFocus;
  final SearchValues preset;
  final SearchInputType type;
  final VoidCallback? onTap;
  final TextEditingController controller;
  final Function(String)? goToSearchResult;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: <Widget>[
        Hero(
          tag: preset.inputHeroTag,
          child: Material(
            child: CoreContainer(
              height: 55,
              child: CoreTextField.outline(
                inputFocusNode: inputFocus,
                onTap: onTap,
                prefixIcon: const CoreContainer(
                  margin: CoreSpacing(
                    bottom: CoreSpacingType.medium,
                    horizontal: CoreSpacingType.medium,
                  ),
                  child: SizedBox.shrink(),
                ),
                controller: controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (String value) {
                  if (value != '') {
                    goToSearchResult?.call(value);
                  }
                },
                placeholder: 'O que está procurando?',
                suffixIconOnTap: controller.clear,
                suffixIcon: Visibility(
                  visible: type == SearchInputType.enable &&
                      controller.text.isNotEmpty,
                  child: const CoreIcon(icon: Icons.close),
                ),
              ),
            ),
          ),
        ),
        CoreContainer(
          padding: const CoreSpacing(
            all: CoreSpacingType.small,
          ),
          margin: const CoreSpacing(
            bottom: CoreSpacingType.medium,
          ),
          child: IconSearchComponent(
            type: preset.iconHeroTag,
          ),
        )
      ],
    );
  }
}
