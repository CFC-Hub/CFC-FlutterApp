import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CFCAppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final TextDecoration decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final List<Shadow>? shadows;
  final FontStyle? fontStyle;

  const CFCAppText({
    Key? key,
    required this.text,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w400,
    this.color = CFCAppColors.textColorDark,
    this.textAlign = TextAlign.start,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
    this.height,
    this.shadows,
    this.fontStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      style: GoogleFonts.lexendDeca(
        decoration: decoration,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: height,
        shadows: shadows,
        fontStyle: fontStyle,
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
