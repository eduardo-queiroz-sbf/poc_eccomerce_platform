import 'package:foundation/infra/router/core_navigator.dart';
import 'package:foundation/interfaces/builders/containers/search_header_builder.dart';
import 'package:foundation/interfaces/builders/screens/search.dart';
// import './input_search.dart';
import 'package:foundation/infra/util/constrains.dart';
import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_icon.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:uuid/uuid.dart';

class SearchHeaderContainer extends StatefulWidget
    implements SearchHeaderContainerInterface {
  @override
  State<SearchHeaderContainer> createState() => SearchHeader();
}

class SearchHeader extends State<SearchHeaderContainer> {
  String? currentSearchedQueryTag;

  Function(String) _goToSearchResult(BuildContext context) {
    return (String query) {
      setState(() {
        currentSearchedQueryTag = const Uuid().v4();
      });
      // widget.goToSearchResult(context, query, currentSearchedQueryTag);
    };
  }

  @override
  Widget build(BuildContext context) {
    // final TextEditingController controller =
    //     context.read<SearchQueryAnimation>().state.input;
    // final FocusNode inputFocus =
    //     context.read<SearchQueryAnimation>().state.focus;
    // final String query = context.read<SearchQueryAnimation>().state.value;
    // final String? initialsearchedQueryTag =
    //     context.read<SearchRoute>().searchedQueryTag;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            CoreNavigator.of(context).pop();
          },
          child: const CoreContainer(
            padding: CoreSpacing(
              vertical: CoreSpacingType.medium,
              right: CoreSpacingType.small,
            ),
            child: CoreIcon(
              icon: Icons.access_alarm,
            ),
          ),
        ),
        CoreContainer(
          width: Constrains().width(83),
          margin: const CoreSpacing(bottom: CoreSpacingType.medium),
          child: CoreContainer(
            margin: const CoreSpacing(
              top: CoreSpacingType.small,
              horizontal: CoreSpacingType.medium,
            ),
            // child: Stack(
            //   alignment: AlignmentDirectional.centerStart,
            //   children: <Widget>[
            //     InputSearchComponent(
            //       type: SearchInputType.enable,
            //       // controller: controller,
            //       goToSearchResult: _goToSearchResult(context),
            //       // inputFocus: inputFocus,
            //     ),
            //     // AnimatedOpacity(
            //     //   opacity: controller.text ==
            //     //           SearchQueryAnimation.hideQueryInputPlaceholder
            //     //       ? 1.0
            //     //       : 0.0,
            //     //   duration: kAnimationRoute,
            //     //   child: CoreContainer(
            //     //     width: controller.text ==
            //     //             SearchQueryAnimation.hideQueryInputPlaceholder
            //     //         ? 200
            //     //         : 0,
            //     //     height: 20,
            //     //     margin: const CoreSpacing(
            //     //       left: CoreSpacingType.large,
            //     //       bottom: CoreSpacingType.medium,
            //     //     ),
            //     //     child: Hero(
            //     //       tag: currentSearchedQueryTag ??
            //     //           initialsearchedQueryTag ??
            //     //           '',
            //     //       child: Material(
            //     //         child: CoreTypography.bodyText1Normal(query),
            //     //       ),
            //     //     ),
            //     //   ),
            //     // ),
            //   ],
            // ),
          ),
        ),
      ],
    );
  }
}
