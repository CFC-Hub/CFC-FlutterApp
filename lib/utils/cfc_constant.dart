import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CFCConstant {
  static const String appName = 'CFC';
  static const String appNameFullName = 'Crowdfield Companion';
  static const firebaseMode = String.fromEnvironment('FIREBASE_MODE', defaultValue: 'DEV');
  static final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  static final DateFormat timeFormat = DateFormat('hh:mm a');
  static final DateFormat dateTimeFormat = DateFormat('dd-MM-yyyy hh:mm a');
  static const double leadingWidth = 30.0;
  static String environmentFileName = '.env';

  static final LengthLimitingTextInputFormatter limitingTextInputFormatter = LengthLimitingTextInputFormatter(180);

  static const String appLogoUrl =
      'https://firebasestorage.googleapis.com/v0/b/cfc-trublo-b47e5.appspot.com/o/public%2Fcfc_logo.png?alt=media&token=05c0eb9d-94f6-400d-9adb-8414efa02161';
}
