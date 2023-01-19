import 'package:cfc/hive/cfc_hives.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CFCPopProfileHive {
  final Box<PopProfile> _box = Hive.box<PopProfile>(CFCHiveBoxNames.popProfileBox);
  final String _storePopProfileKey = 'storePopProfileKey';

  Future<void> setPopProfile(PopProfile popProfile) async {
    await _box.put(_storePopProfileKey, popProfile);
  }

  PopProfile? getPopProfile() {
    return _box.get(_storePopProfileKey);
  }

  Future<void> deletePopProfile() async {
    await _box.delete(_storePopProfileKey);
  }
}
