import 'dart:math';

import 'package:fairplay_ds/enums/credit_card.enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_animation.dart';
import 'package:flutter_credit_card/credit_card_background.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';

class CoreCreditCardValidator {
  RegExp amex() => RegExp(
        '^3[47]',
      );
  RegExp masterCard() =>
      RegExp('^(5[1-5]|677189)|^(222[1-9]|2[3-6]\d{2}|27[0-1]\d|2720)\$');
  RegExp visa() => RegExp('^4[0-9]{6,}\$');
  RegExp hipercard() => RegExp(
        '^(384100|384140|384160|606282|637095|637568|60(?!11))\$',
      );
  RegExp elo() => RegExp(
      '^401178|^401179|^431274|^438935|^451416|^457393|^457631|^457632|^504175|^627780|^636297|^636369|^636368|^(506699|5067[0-6]\d|50677[0-8])|^(50900\d|5090[1-9]\d|509[1-9]\d{2})|^65003[1-3]|^(65003[5-9]|65004\d|65005[0-1])|^(65040[5-9]|6504[1-3]\d)|^(65048[5-9]|65049\d|6505[0-2]\d|65053[0-8])|^(65054[1-9]|6505[5-8]\d|65059[0-8])|^(65070\d|65071[0-8])|^65072[0-7]|^(65090[1-9]|65091\d|650920)|^(65165[2-9]|6516[6-7]\d)|^(65500\d|65501\d)|^(65502[1-9]|6550[3-4]\d|65505[0-8])|^(65092[1-9]|65097[0-8])/');

  CardTypes getCardType(String numbers) {
    if (amex().hasMatch(numbers)) {
      return CardTypes.americanExpress;
    }
    // Hipercard must be placed before Mastercard
    if (hipercard().hasMatch(numbers)) {
      return CardTypes.hipercard;
    }
    if (masterCard().hasMatch(numbers)) {
      return CardTypes.mastercard;
    }
    if (visa().hasMatch(numbers)) {
      return CardTypes.visa;
    }
    if (elo().hasMatch(numbers)) {
      return CardTypes.elo;
    }
    return CardTypes.otherBrand;
  }
}

class CoreCreditCardUtils extends CoreCreditCardValidator {
  String cardTypeIcons(CardTypes type) {
    const Map<CardTypes, String> cardTypes = {
      CardTypes.visa: 'icons/visa.png',
      CardTypes.americanExpress: 'icons/amex.png',
      CardTypes.mastercard: 'icons/mastercard.png',
      CardTypes.discover: 'icons/discover.png',
      CardTypes.elo: 'icons/discover.png',
      CardTypes.hipercard: 'icons/discover.png',
    };

    return cardTypes[type] ?? '';
  }
}

class CustomCardTypeIcon {
  CustomCardTypeIcon({
    required this.cardType,
    required this.cardImage,
  });

  CardTypes cardType;
  Widget cardImage;
}

class CoreCreditCard extends StatefulWidget {
  const CoreCreditCard({
    Key? key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.showBackView,
    this.animationDuration = const Duration(milliseconds: 500),
    this.height,
    this.width,
    this.textStyle,
    this.cardBgColor = const Color(0xff1b447b),
    this.obscureCardNumber = true,
    this.obscureCardCvv = true,
    this.labelCardHolder = 'CARD HOLDER',
    this.labelExpiredDate = 'MM/YY',
    this.labelExpired = 'VALID\nTHRU',
    this.labelEmptyCardNumber = 'XXXX XXXX XXXX XXXX',
    this.cardType,
    this.isHolderNameVisible = false,
    this.backgroundImage,
    this.glassmorphismConfig,
    this.isChipVisible = true,
    this.isSwipeGestureEnabled = true,
    this.customCardTypeIcons = const <CustomCardTypeIcon>[],
  }) : super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final TextStyle? textStyle;
  final Color cardBgColor;
  final bool showBackView;
  final Duration animationDuration;
  final double? height;
  final double? width;
  final bool obscureCardNumber;
  final bool obscureCardCvv;
  final bool isHolderNameVisible;
  final String? backgroundImage;
  final bool isChipVisible;
  final Glassmorphism? glassmorphismConfig;
  final bool isSwipeGestureEnabled;

  final String labelCardHolder;
  final String labelExpiredDate;
  final String labelExpired;
  final String labelEmptyCardNumber;

  final CardTypes? cardType;
  final List<CustomCardTypeIcon> customCardTypeIcons;

  @override
  _CoreCreditCard createState() => _CoreCreditCard();
}

class _CoreCreditCard extends State<CoreCreditCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _frontRotation;
  late Animation<double> _backRotation;
  late Gradient backgroundGradientColor;
  late bool isFrontVisible = true;
  late bool isGestureUpdate = false;

  CoreCreditCardUtils coreCreditCardUtils = CoreCreditCardUtils();

  bool isAmex = false;

  @override
  void initState() {
    super.initState();

    ///initialize the animation controller
    controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _gradientSetup();
    _updateRotations(false);
  }

  void _gradientSetup() {
    backgroundGradientColor = LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const <double>[0.1, 0.4, 0.7, 0.9],
      colors: <Color>[
        widget.cardBgColor.withOpacity(1),
        widget.cardBgColor.withOpacity(0.97),
        widget.cardBgColor.withOpacity(0.90),
        widget.cardBgColor.withOpacity(0.86),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///
    /// If uer adds CVV then toggle the card from front to back..
    /// controller forward starts animation and shows back layout.
    /// controller reverse starts animation and shows front layout.
    ///
    if (!isGestureUpdate) {
      _updateRotations(false);
      if (widget.showBackView) {
        controller.forward();
      } else {
        controller.reverse();
      }
    } else {
      isGestureUpdate = false;
    }

    return Stack(
      children: <Widget>[
        _cardGesture(
          child: AnimationCard(
            animation: _frontRotation,
            child: _buildFrontContainer(),
          ),
        ),
        _cardGesture(
          child: AnimationCard(
            animation: _backRotation,
            child: _buildBackContainer(),
          ),
        ),
      ],
    );
  }

  void _leftRotation() {
    _toggleSide(false);
  }

  void _rightRotation() {
    _toggleSide(true);
  }

  void _toggleSide(bool isRightTap) {
    _updateRotations(!isRightTap);
    if (isFrontVisible) {
      controller.forward();
      isFrontVisible = false;
    } else {
      controller.reverse();
      isFrontVisible = true;
    }
  }

  void _updateRotations(bool isRightSwipe) {
    setState(() {
      final bool rotateToLeft =
          (isFrontVisible && !isRightSwipe) || !isFrontVisible && isRightSwipe;

      ///Initialize the Front to back rotation tween sequence.
      _frontRotation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: 0.0,
              end: rotateToLeft ? (pi / 2) : (-pi / 2),
            ).chain(CurveTween(curve: Curves.linear)),
            weight: 50.0,
          ),
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(rotateToLeft ? (-pi / 2) : (pi / 2)),
            weight: 50.0,
          ),
        ],
      ).animate(controller);

      ///Initialize the Back to Front rotation tween sequence.
      _backRotation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(rotateToLeft ? (pi / 2) : (-pi / 2)),
            weight: 50.0,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: rotateToLeft ? (-pi / 2) : (pi / 2),
              end: 0.0,
            ).chain(
              CurveTween(curve: Curves.linear),
            ),
            weight: 50.0,
          ),
        ],
      ).animate(controller);
    });
  }

  ///
  /// Builds a front container containing
  /// Card number, Exp. year and Card holder name
  ///
  Widget _buildFrontContainer() {
    final TextStyle defaultTextStyle =
        Theme.of(context).textTheme.headline6!.merge(
              const TextStyle(
                color: Colors.white,
                fontFamily: 'halter',
                fontSize: 16,
                package: 'flutter_credit_card',
              ),
            );

    final String number = widget.obscureCardNumber
        ? widget.cardNumber.replaceAll(RegExp(r'(?<=.{4})\d(?=.{4})'), '*')
        : widget.cardNumber;
    return CardBackground(
      backgroundImage: widget.backgroundImage,
      backgroundGradientColor: backgroundGradientColor,
      glassmorphismConfig: widget.glassmorphismConfig,
      height: widget.height,
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: widget.isChipVisible ? 2 : 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (widget.isChipVisible)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Image.asset(
                      'icons/chip.png',
                      package: 'flutter_credit_card',
                      scale: 1,
                    ),
                  ),
                const Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: widget.cardType != null
                        ? getCardTypeImage(widget.cardType)
                        : getCardTypeIcon(widget.cardNumber),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                widget.cardNumber.isEmpty
                    ? widget.labelEmptyCardNumber
                    : number,
                style: widget.textStyle ?? defaultTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.labelExpired,
                    style: widget.textStyle?.copyWith(fontSize: 7) ??
                        defaultTextStyle.copyWith(fontSize: 7),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.expiryDate.isEmpty
                        ? widget.labelExpiredDate
                        : widget.expiryDate,
                    style: widget.textStyle?.copyWith(fontSize: 16) ??
                        defaultTextStyle,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.isHolderNameVisible,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Text(
                  widget.cardHolderName.isEmpty
                      ? widget.labelCardHolder
                      : widget.cardHolderName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: widget.textStyle?.copyWith(fontSize: 16) ??
                      defaultTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Builds a back container containing cvv
  ///
  Widget _buildBackContainer() {
    final TextStyle defaultTextStyle =
        Theme.of(context).textTheme.headline6!.merge(
              const TextStyle(
                color: Colors.black,
                fontFamily: 'halter',
                fontSize: 16,
                package: 'flutter_credit_card',
              ),
            );

    final String cvv = widget.obscureCardCvv
        ? widget.cvvCode.replaceAll(RegExp(r'\d'), '*')
        : widget.cvvCode;

    return CardBackground(
      backgroundImage: widget.backgroundImage,
      backgroundGradientColor: backgroundGradientColor,
      glassmorphismConfig: widget.glassmorphismConfig,
      height: widget.height,
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              height: 48,
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: Container(
                      height: 48,
                      color: Colors.white70,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          widget.cvvCode.isEmpty
                              ? isAmex
                                  ? 'XXXX'
                                  : 'XXX'
                              : cvv,
                          maxLines: 1,
                          style: widget.textStyle?.copyWith(fontSize: 18) ??
                              defaultTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: widget.cardType != null
                    ? getCardTypeImage(widget.cardType)
                    : getCardTypeIcon(widget.cardNumber),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardGesture({required Widget child}) {
    bool isRightSwipe = true;
    return widget.isSwipeGestureEnabled
        ? GestureDetector(
            onPanEnd: (_) {
              isGestureUpdate = true;
              if (isRightSwipe) {
                _leftRotation();
              } else {
                _rightRotation();
              }
            },
            onPanUpdate: (DragUpdateDetails details) {
              // Swiping in right direction.
              if (details.delta.dx > 0) {
                isRightSwipe = true;
              }

              // Swiping in left direction.
              if (details.delta.dx < 0) {
                isRightSwipe = false;
              }
            },
            child: child,
          )
        : child;
  }

  /// This function determines the Credit Card type based on the cardPatterns
  /// and returns it.

  Widget getCardTypeImage(CardTypes? cardType) {
    final List<CustomCardTypeIcon> customCardTypeIcon =
        getCustomCardTypeIcon(cardType!);
    if (customCardTypeIcon.isNotEmpty) {
      return customCardTypeIcon.first.cardImage;
    } else {
      return Image.asset(
        coreCreditCardUtils.cardTypeIcons(cardType),
        height: 48,
        width: 48,
        package: 'flutter_credit_card',
      );
    }
  }

  // This method returns the icon for the visa card type if found
  // else will return the empty container
  Widget getCardTypeIcon(String cardNumber) {
    Widget icon;
    final CardTypes ccType =
        coreCreditCardUtils.getCardType(cardNumber.replaceAll(' ', ''));
    final List<CustomCardTypeIcon> customCardTypeIcon =
        getCustomCardTypeIcon(ccType);
    if (customCardTypeIcon.isNotEmpty) {
      icon = customCardTypeIcon.first.cardImage;
      isAmex = ccType == CardType.americanExpress;
    } else {
      switch (ccType) {
        case CardTypes.visa:
          icon = Image.asset(
            coreCreditCardUtils.cardTypeIcons(ccType),
            height: 48,
            width: 48,
            package: 'flutter_credit_card',
          );
          isAmex = false;
          break;

        case CardTypes.americanExpress:
          icon = Image.asset(
            coreCreditCardUtils.cardTypeIcons(ccType),
            height: 48,
            width: 48,
            package: 'flutter_credit_card',
          );
          isAmex = true;
          break;

        case CardTypes.mastercard:
          icon = Image.asset(
            coreCreditCardUtils.cardTypeIcons(ccType),
            height: 48,
            width: 48,
            package: 'flutter_credit_card',
          );
          isAmex = false;
          break;

        case CardTypes.discover:
          icon = Image.asset(
            coreCreditCardUtils.cardTypeIcons(ccType),
            height: 48,
            width: 48,
            package: 'flutter_credit_card',
          );
          isAmex = false;
          break;
        case CardTypes.elo:
          icon = Image.asset(
            coreCreditCardUtils.cardTypeIcons(ccType),
            height: 48,
            width: 48,
            package: 'flutter_credit_card',
          );
          isAmex = false;
          break;
        case CardTypes.hipercard:
          icon = Image.asset(
            coreCreditCardUtils.cardTypeIcons(ccType),
            height: 48,
            width: 48,
            package: 'flutter_credit_card',
          );
          isAmex = false;
          break;

        default:
          icon = Container(
            height: 48,
            width: 48,
          );
          isAmex = false;
          break;
      }
    }

    return icon;
  }

  List<CustomCardTypeIcon> getCustomCardTypeIcon(CardTypes currentCardType) =>
      widget.customCardTypeIcons
          .where(
            (CustomCardTypeIcon element) => element.cardType == currentCardType,
          )
          .toList();
}

class MaskedTextController extends TextEditingController {
  MaskedTextController(
      {String? text, required this.mask, Map<String, RegExp>? translator})
      : super(text: text) {
    this.translator = translator ?? MaskedTextController.getDefaultTranslator();

    addListener(() {
      final String previous = _lastUpdatedText;
      if (beforeChange(previous, this.text)) {
        updateText(this.text);
        afterChange(previous, this.text);
      } else {
        updateText(_lastUpdatedText);
      }
    });

    updateText(this.text);
  }

  String mask;

  late Map<String, RegExp> translator;

  void Function(String previous, String next) afterChange =
      (String previous, String next) {};
  bool Function(String previous, String next) beforeChange =
      (String previous, String next) {
    return true;
  };

  String _lastUpdatedText = '';

  void updateText(String text) {
    if (text.isNotEmpty) {
      this.text = _applyMask(mask, text);
    } else {
      this.text = '';
    }

    _lastUpdatedText = this.text;
  }

  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    updateText(text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    final String text = _lastUpdatedText;
    selection = TextSelection.fromPosition(TextPosition(offset: text.length));
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return <String, RegExp>{
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*')
    };
  }

  String _applyMask(String? mask, String value) {
    String result = '';

    int maskCharIndex = 0;
    int valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask!.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      final String maskChar = mask[maskCharIndex];
      final String valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (translator.containsKey(maskChar)) {
        if (translator[maskChar]!.hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}
