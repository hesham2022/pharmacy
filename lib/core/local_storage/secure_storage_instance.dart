import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'loca_storage_keys.dart';

class Storage {
  static FlutterSecureStorage get prefs => const FlutterSecureStorage();

  // isFirstKey
  static Future<bool> isFirst() async {
    if ((await prefs.read(key: isFirstKey)) == null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> setPassword(String password) async =>
      prefs.write(key: passKey, value: password);

  static Future<void> setUserType(String user) async =>
      prefs.write(key: 'userType', value: user);
  static Future<String?> getUserType() async => prefs.read(key: 'userType');
  static Future<void> removeUserType() async => prefs.delete(key: 'userType');
  static Future<void> setLang(String user) async =>
      prefs.write(key: 'lang', value: user);
  static Future<String?> getLang() async => prefs.read(key: 'lang');
  static Future<void> removeLang() async => prefs.delete(key: 'lang');
  static Future<void> setRole(String role) async =>
      prefs.write(key: 'role', value: role);
  static Future<String?> getRole() async => prefs.read(key: 'role');
  static Future<void> removeRole() async => prefs.delete(key: 'role');
  static Future<String?> getPassword() async => prefs.read(key: passKey);

  static Future<void> setIsFirst() async =>
      prefs.write(key: isFirstKey, value: isFirstKey);
  static Future<void> removeIsFirst() async => prefs.delete(key: isFirstKey);
  static Future<void> removePassword() async => prefs.delete(key: passKey);
}
