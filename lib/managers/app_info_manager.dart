import 'dart:developer';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutternow/constants/prefrences_keys.dart';
import 'package:flutternow/managers/preferences_manager.dart';
import 'package:flutternow/models/app_info_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

class AppInfoManager {
  static final String _tag = 'AppInfoManager';

  AppInfoManager._();

  static AppInfoManager? _instance;

  static AppInfoManager get instance {
    _instance ??= AppInfoManager._();
    return _instance!;
  }

  bool _init = false;

  late AppInfoModel _appInfoModel;

  bool _initCheck() {
    if (!_init) {
      log('$_tag 未初始化⚠️', name: _tag);
    }
    return _init;
  }

  /// 初始化App环境信息
  Future<void> init() async {
    if (_initCheck()) {
      log('$_tag 已初始化', name: _tag);
      return;
    }
    String deviceId = '', deviceModel = '', systemVersion = '';
    try {
      final deviceInfo = await DeviceInfoPlugin().deviceInfo;
      final packageInfo = await PackageInfo.fromPlatform();
      if (deviceInfo is AndroidDeviceInfo) {
        String? id = await AndroidId().getId();
        if (id == null || id.isEmpty) {
          // 获取不到android id，生成一个存在本地
          final localDeviceId =
              PreferencesManager.instance.getString(PreferencesKeys.deviceId) ??
                  '';
          if (localDeviceId.isEmpty) {
            id = const Uuid().v1();
            PreferencesManager.instance.setString(PreferencesKeys.deviceId, id);
          } else {
            id = localDeviceId;
          }
        }
        deviceId = id;
        deviceModel = deviceInfo.model;
        systemVersion = deviceInfo.version.sdkInt.toString();
      } else if (deviceInfo is IosDeviceInfo) {
        String? id = deviceInfo.identifierForVendor;
        if (id == null || id.isEmpty) {
          final localDeviceId =
              PreferencesManager.instance.getString(PreferencesKeys.deviceId) ??
                  '';
          if (localDeviceId.isEmpty) {
            id = const Uuid().v1();
            PreferencesManager.instance.setString(PreferencesKeys.deviceId, id);
          } else {
            id = localDeviceId;
          }
        }
        deviceId = id;
        deviceModel = deviceInfo.utsname.machine;
        systemVersion = deviceInfo.systemVersion;
      }

      _appInfoModel = AppInfoModel(
        packageName: packageInfo.packageName,
        appVersion: packageInfo.version,
        deviceId: deviceId,
        deviceModel: deviceModel,
        systemVersion: systemVersion,
        firstLaunch: false,
      );

      _init = true;
      log('$_tag 初始化完成✅.', name: _tag);
    } catch (e) {
      log('$_tag 初始化错误❌: $e', name: _tag);
    }
  }

  /// 获取AppInfoModel
  AppInfoModel? get appInfoModel {
    if (!_initCheck()) {
      return null;
    }
    log('appInfoModel: ${_appInfoModel.toJson()}', name: _tag);
    return _appInfoModel;
  }
}
