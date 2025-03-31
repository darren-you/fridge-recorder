import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

/// 本地轻量存储
/// 基于shared_preferences
class PreferencesManager {
  static final String _tag = 'LocalStorageManager';
  PreferencesManager._();

  static PreferencesManager? _instance;

  static PreferencesManager get instance {
    _instance ??= PreferencesManager._();
    return _instance!;
  }

  bool _init = false;
  late SharedPreferences prefs;

  bool _initCheck() {
    if (!_init) {
      log('LocalStorageManager 未初始化⚠️', name: _tag);
    }
    return _init;
  }

  /// 初始化
  Future<void> init() async {
    if (_initCheck()) {
      log('LocalStorageManager 已初始化', name: _tag);
      return;
    }
    try {
      prefs = await SharedPreferences.getInstance();
      _init = true;
      log('LocalStorageManager 初始化完成✅.', name: _tag);
    } catch (e) {
      log('LocalStorageManager 初始化错误❌: $e', name: _tag);
    }
  }

  String? getString(String key) {
    if (!_initCheck()) {
      return null;
    }
    return prefs.getString(key);
  }

  /// value为null则remove
  void setString(String key, String? value) {
    if (!_initCheck()) {
      return;
    }
    if (value != null) {
      prefs.setString(key, value);
    } else {
      prefs.remove(key);
    }
  }

  int? getInt(String key) {
    if (!_initCheck()) {
      return null;
    }
    return prefs.getInt(key);
  }

  /// value为null则remove
  void setInt(String key, int? value) {
    if (!_initCheck()) {
      return;
    }
    if (value != null) {
      prefs.setInt(key, value);
    } else {
      prefs.remove(key);
    }
  }

  bool? getBool(String key) {
    if (!_initCheck()) {
      return null;
    }
    return prefs.getBool(key);
  }

  /// value为null则remove
  void setBool(String key, bool? value) {
    if (!_initCheck()) {
      return;
    }
    if (value != null) {
      prefs.setBool(key, value);
    } else {
      prefs.remove(key);
    }
  }
}
