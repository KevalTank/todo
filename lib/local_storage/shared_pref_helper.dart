import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SharedPrefHelper {
  SharedPrefHelper._internal();

  static final SharedPrefHelper sharedPrefHelper = SharedPrefHelper._internal();

  factory SharedPrefHelper() {
    return sharedPrefHelper;
  }

  static late SharedPreferences _prefs;
  static const String _kFirebaseUserId = "_kFirebaseUserId";

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getFirebaseUserId() {
    if (_prefs.containsKey(_kFirebaseUserId) && _prefs.getString(_kFirebaseUserId) != null) {
      debugPrint('-------------------------------------------------------------------------------');
      debugPrint("SharedPrefHelper - getFirebaseUserId : ${_prefs.getString(_kFirebaseUserId)}");
      debugPrint('-------------------------------------------------------------------------------');
      return _prefs.getString(_kFirebaseUserId)!;
    } else {
      String tempUuid = const Uuid().v1();
      saveFirebaseUserId(tempUuid);
      debugPrint('-------------------------------------------------------------------------------');
      debugPrint("SharedPrefHelper - getFirebaseUserId (UUID) : $tempUuid");
      debugPrint('-------------------------------------------------------------------------------');
      return tempUuid;
    }
  }

  static Future<bool> saveFirebaseUserId(String id) async {
    debugPrint('-------------------------------------------------------------------------------');
    debugPrint("SharedPrefHelper - saveFirebaseUserId : $id");
    debugPrint('-------------------------------------------------------------------------------');
    return await _prefs.setString(_kFirebaseUserId, id);
  }

  static Future<bool> clear() async {
    return await _prefs.clear();
  }
}
