import 'package:foundation/infra/constants/animation.dart';
import 'package:fairplay_ds/core/core_container.dart';
import 'package:fairplay_ds/core/core_shimmer.dart';
import 'package:fairplay_ds/theme/interfaces/color_theme.dart';
import 'package:fairplay_ds/theme/interfaces/spacing_theme.dart';

import 'package:flutter/material.dart';

class LoadingSuggestionComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: kAnimationDefault,
        child: CoreShimmer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CoreContainer(
                padding: CoreSpacing(bottom: CoreSpacingType.medium),
                child: CoreContainer(
                  radius: true,
                  height: 22,
                  width: 230,
                  color: CoreColorType.neutralWhite,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 8,
                  separatorBuilder: (BuildContext context, int index) =>
                      const CoreContainer.small(),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: const <Widget>[
                        CoreContainer(
                          padding: CoreSpacing(right: CoreSpacingType.small),
                          child: CoreContainer(
                            radius: true,
                            height: 20,
                            width: 20,
                            color: CoreColorType.neutralWhite,
                          ),
                        ),
                        CoreContainer(
                          radius: true,
                          height: 20,
                          width: 250,
                          color: CoreColorType.neutralWhite,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
