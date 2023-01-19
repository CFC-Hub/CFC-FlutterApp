import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CFCMaterialButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Color fontColor;
  final double? fontSize;
  final FontWeight fontWeight;
  final bool enabled;
  final bool isAlternateButton;
  final Color buttonBackgroundColor;
  final Color buttonBorderColor;
  final VoidCallback? onPressed;
  final String loadingText;
  final Color loadingColor;

  const CFCMaterialButton({
    Key? key,
    required this.text,
    this.width,
    this.height = 50.0,
    this.fontColor = CFCAppColors.white,
    this.fontSize = 18.0,
    this.fontWeight = FontWeight.w700,
    this.enabled = true,
    this.isAlternateButton = false,
    this.buttonBackgroundColor = CFCAppColors.primaryButtonColor,
    this.buttonBorderColor = CFCAppColors.primaryButtonColor,
    required this.onPressed,
    this.loadingText = 'Please wait...',
    this.loadingColor = CFCAppColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
              color: enabled
                  ? isAlternateButton
                      ? Colors.black26
                      : buttonBorderColor
                  : Colors.grey,
              width: 0.5,
              style: BorderStyle.solid),
          color: enabled
              ? isAlternateButton
                  ? Colors.black54
                  : buttonBackgroundColor
              : Colors.grey,
        ),
        child: MaterialButton(
          onPressed: enabled ? onPressed : null,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.lexendDeca(
              fontSize: fontSize,
              color: fontColor,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
