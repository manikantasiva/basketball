import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String? thirdText;

  final Color firstColor;
  final Color secondColor;
  final Color? thirdColor;

  final double firstFontSize;
  final double secondFontSize;
  final double? thirdFontSize;

  final FontWeight firstFontWeight;
  final FontWeight secondFontWeight;
  final FontWeight? thirdFontWeight;

  final TextAlign textAlign;

  const CustomRichText({
    Key? key,
    required this.firstText,
    required this.secondText,
    this.thirdText,

    this.firstColor = Colors.white,
    this.secondColor = Colors.orange,
    this.thirdColor,

    this.firstFontSize = 30,
    this.secondFontSize = 32,
    this.thirdFontSize,

    this.firstFontWeight = FontWeight.w500,
    this.secondFontWeight = FontWeight.w600,
    this.thirdFontWeight,

    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: textAlign,
          text: TextSpan(
            children: [
              TextSpan(
                text: firstText,
                style: TextStyle(
                  color: firstColor,
                  fontSize: firstFontSize,
                  fontWeight: firstFontWeight,
                ),
              ),
              TextSpan(
                text: secondText,
                style: TextStyle(
                  color: secondColor,
                  fontSize: secondFontSize,
                  fontWeight: secondFontWeight,
                ),
              ),
            ],
          ),
        ),
        if (thirdText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              thirdText!,
              textAlign: textAlign,
              style: TextStyle(
                color: thirdColor ?? Colors.grey,
                fontSize: thirdFontSize ?? 18,
                fontWeight: thirdFontWeight ?? FontWeight.normal,
              ),
            ),
          ),
      ],
    );
  }
}
