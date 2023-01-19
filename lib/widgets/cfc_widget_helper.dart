import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CFCWidgetHelper {
  static OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      color: CFCAppColors.textColorDark,
      width: 1.0,
    ),
  );

  static OutlineInputBorder textFieldFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      color: CFCAppColors.textColorDark,
      width: 1.0,
    ),
  );

  static OutlineInputBorder textFieldErrorFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      // color: CFCAppColors.textColorDark,
      width: 1.0,
    ),
  );

  static TextStyle inputHintStyle = GoogleFonts.lexendDeca(
    fontSize: 16.0,
    color: Colors.black26,
    fontWeight: FontWeight.w400,
  );

  static TextStyle inputLabelStyle = GoogleFonts.lexendDeca(
    fontSize: 16.0,
    color: CFCAppColors.textColorDark,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textFieldStyle = GoogleFonts.lexendDeca(
    fontSize: 16.0,
    color: Colors.black87,
    fontWeight: FontWeight.w400,
  );

  static const AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: CFCAppColors.appPrimaryColor,
    centerTitle: false,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(
      color: CFCAppColors.white,
    ),
  );

  static const double leadingWidth = 24.0;

  static const Widget loadingWidget = SizedBox(
    height: 50,
    width: 50,
    child: LoadingIndicator(
      indicatorType: Indicator.ballRotateChase,
      colors: [
        CFCAppColors.appPrimaryColor,
      ],
    ),
  );
}
