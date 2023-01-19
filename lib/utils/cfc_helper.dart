import 'dart:io';

import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class CFCHelper {
  static void showError({
    String? title,
    required String message,
    Duration? duration,
    Widget? icon,
    bool enableBtn = false,
    String? buttonText,
    VoidCallback? buttonOnPress,
  }) {
    if (enableBtn && duration == null) {
      duration = const Duration(seconds: 10);
    }
    Get.closeCurrentSnackbar();
    Get.showSnackbar(
      GetSnackBar(
        titleText: title != null
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_sharp, color: Colors.white),
                  const SizedBox(width: 5),
                  Flexible(
                    child: CFCAppText(
                      text: title,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            : null,
        messageText: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CFCAppText(
                text: message,
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
            if (enableBtn) ...[
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CFCMaterialButton(
                        text: buttonText != null ? buttonText.toUpperCase() : 'OK',
                        height: 38.0,
                        fontSize: 16.0,
                        buttonBackgroundColor: Colors.transparent,
                        buttonBorderColor: Colors.white,
                        onPressed: buttonOnPress ??
                            () {
                              Get.closeAllSnackbars();
                            },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
        icon: icon,
        borderRadius: 10.0,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        backgroundColor: CFCAppColors.appErrorBackground,
        duration: duration ?? const Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
      ),
    );
  }

  static void showMessage({
    String? title,
    required String message,
    Duration? duration,
    Widget? icon,
    bool enableBtn = false,
    String? buttonText,
    VoidCallback? buttonOnPress,
  }) {
    if (enableBtn && duration == null) {
      duration = const Duration(seconds: 10);
    }
    Get.closeAllSnackbars();
    Get.showSnackbar(
      GetSnackBar(
        titleText: title != null
            ? Align(
                alignment: Alignment.center,
                child: CFCAppText(
                  text: title,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
              )
            : null,
        messageText: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CFCAppText(
                text: message,
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
            if (enableBtn) ...[
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CFCMaterialButton(
                        text: buttonText != null ? buttonText.toUpperCase() : 'OK',
                        height: 32.0,
                        fontSize: 16.0,
                        buttonBackgroundColor: Colors.transparent,
                        buttonBorderColor: Colors.white,
                        onPressed: buttonOnPress ??
                            () {
                              Get.closeAllSnackbars();
                            },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
        icon: icon,
        borderRadius: 10.0,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        backgroundColor: CFCAppColors.primaryButtonColor,
        duration: duration ?? const Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
      ),
    );
  }

  static String truncateString(String text, int front, int end) {
    int size = front + end;

    if (text.length > size) {
      String finalString = "${text.substring(0, front)}...${text.substring(text.length - end)}";
      return finalString;
    }

    return text;
  }

  static Future<DeviceInfo> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    DeviceInfo info = DeviceInfo(platform: '', deviceName: '', isPhysicalDevice: '', version: '');
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;
      info = info.copyWith(
        platform: 'Web'.toLowerCase(),
        deviceName: webBrowserInfo.platform,
        isPhysicalDevice: 'true',
        version: webBrowserInfo.browserName.name,
      );
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      info = info.copyWith(
        platform: 'Android'.toLowerCase(),
        deviceName: androidInfo.manufacturer,
        isPhysicalDevice: androidInfo.data['isPhysicalDevice'].toString(),
        version: androidInfo.version.release,
      );
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfoPlugin.iosInfo;
      info = info.copyWith(
        platform: 'IOS'.toLowerCase(),
        deviceName: iosInfo.name ?? 'unknown',
        isPhysicalDevice: iosInfo.data['isPhysicalDevice'].toString(),
        version: iosInfo.systemVersion ?? 'unknown',
      );
    }
    return info;
  }

  static String generateUUID({bool keepHyphens = false}) {
    const uuid = Uuid();
    final x = uuid.v4(options: {'grng': UuidUtil.cryptoRNG});
    return keepHyphens ? x : x.replaceAll('-', '');
  }

  static String getDateFromMillisecondsSinceEpoch(int millisecondsSinceEpoch) {
    try {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
      return CFCConstant.dateFormat.format(date);
    } catch (e) {
      debugPrint(e.toString());
      return '---';
    }
  }

  static String getDateTimeFromMillisecondsSinceEpoch(int millisecondsSinceEpoch) {
    try {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
      return CFCConstant.dateTimeFormat.format(date);
    } catch (e) {
      debugPrint(e.toString());
      return '---';
    }
  }

  static void showBottomAlert({
    required String title,
    required String content,
    required VoidCallback onPressed,
    String buttonText = 'Continue',
  }) {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            CFCAppText(
              text: title,
              color: CFCAppColors.textColorDark,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              fontSize: 18,
            ),
            const SizedBox(height: 20),
            CFCAppText(
              text: content,
              color: CFCAppColors.textColorDark,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: CFCMaterialButton(
                    text: 'Cancel',
                    buttonBackgroundColor: CFCAppColors.lightGreenButtonColor,
                    buttonBorderColor: CFCAppColors.lightGreenButtonColor,
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CFCMaterialButton(
                    text: buttonText,
                    onPressed: onPressed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Map<String, dynamic> get getAccessTokenCredential {
    String key = dotenv.get('KEY');
    String userName = dotenv.get('EMAIL');
    String password = dotenv.get('PASSWORD');
    Map<String, dynamic> payload = {"key": key, "email": userName, "password": password, "returnSecureToken": "true"};
    return payload;
  }
}
