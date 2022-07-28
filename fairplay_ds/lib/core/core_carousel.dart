import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CoreCarousel extends StatefulWidget {
  const CoreCarousel({
    required this.itensList,
    this.shapeIndicator = BoxShape.rectangle,
    this.autoPlay = true,
    this.height = double.infinity,
  });

  final BoxShape shapeIndicator;
  final List<Widget> itensList;
  final double height;
  final bool autoPlay;

  @override
  State<StatefulWidget> createState() => _CoreCarouselState();
}

class _CoreCarouselState extends State<CoreCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _getSlider(),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.itensList.map((Widget url) {
              final int index = widget.itensList.indexOf(url);
              return _getIndicator(index: index);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Container _getIndicator({required int index}) {
    final bool shapeIndicatorIsRectangle =
        widget.shapeIndicator == BoxShape.rectangle;
    final Color indicatorColor = shapeIndicatorIsRectangle
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.primary;

    const double widthRectangle = 40;
    const double widthCircle = 20;
    const double heightRectangle = 2.5;
    const double heightCircle = 10;

    return Container(
      width: shapeIndicatorIsRectangle ? widthRectangle : widthCircle,
      height: shapeIndicatorIsRectangle ? heightRectangle : heightCircle,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        border: Border.all(
          style:
              shapeIndicatorIsRectangle ? BorderStyle.none : BorderStyle.solid,
          width: shapeIndicatorIsRectangle ? 0 : 1,
          color: shapeIndicatorIsRectangle
              ? indicatorColor
              : Theme.of(context).colorScheme.primaryVariant,
        ),
        color: _current == index
            ? indicatorColor
            : Theme.of(context).colorScheme.primaryVariant,
        shape: widget.shapeIndicator,
      ),
    );
  }

  CarouselSlider _getSlider() {
    return CarouselSlider(
      items: widget.itensList,
      options: CarouselOptions(
          height: widget.height,
          viewportFraction: 1,
          autoPlay: widget.autoPlay,
          onPageChanged: (int index, _) {
            setState(() {
              _current = index;
            });
          }),
    );
  }
}
