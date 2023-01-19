import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cfc/hive/cfc_hive_box_names.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class CFCSecureKey {
  late final FlutterSecureStorage _secureStorage;

  CFCSecureKey() {
    if (Platform.isAndroid) {
      AndroidOptions getAndroidOptions = const AndroidOptions(encryptedSharedPreferences: true);
      _secureStorage = FlutterSecureStorage(aOptions: getAndroidOptions);
    } else {
      _secureStorage = const FlutterSecureStorage();
    }
  }

  Future<Uint8List> getPopProfileBoxSecureKey() async {
    return await _getGenerateSecureKey(storeKey: CFCHiveBoxNames.popProfileBox);
  }

  Future<Uint8List> _getGenerateSecureKey({required String storeKey}) async {
    final encryptionKey = await _secureStorage.read(key: storeKey);
    if (encryptionKey != null) {
      return base64Url.decode(encryptionKey);
    }
    final secureKey = Hive.generateSecureKey();
    await _secureStorage.write(key: storeKey, value: base64UrlEncode(secureKey));
    final key = await _secureStorage.read(key: storeKey);
    return base64Url.decode(key!);
  }
}
