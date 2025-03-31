import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_system_proxy/flutter_system_proxy.dart';
import 'package:flutternow/constants/app_define.dart';
import 'package:flutternow/constants/prefrences_keys.dart';
import 'package:flutternow/extensions/fontweight_ext.dart';
import 'package:flutternow/managers/app_info_manager.dart';
import 'package:flutternow/managers/first_launch_manager.dart';
import 'package:flutternow/managers/preferences_manager.dart';
import 'package:flutternow/network/net_log_interceptor.dart';
import 'package:flutternow/network/request_interceptor.dart';
import 'package:get_it/get_it.dart';

import 'network/api_client.dart';

export 'generated/assets.gen.dart';

final _logName = 'app';

/// get_it 依赖注入框架初始化
final getIt = GetIt.instance;
bool isFontWeigthSupportW500 = false;

/// 初始化基础框架
///
/// 1、Flutter从屏幕编译开始绘制
/// 2、SharePreference初始化
/// 3、网络代理初始化
/// 4、EventBus单例依赖注入
/// 5、字重支持判断初始化
Future<void> initBase() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await PreferencesManager.instance.init();
  HttpOverrides.global = await HttpProxyOverride.createHttpProxy();
  getIt.registerSingleton<EventBus>(EventBus());
  FontWeightExt.getFontWeigthSupport();
  log('initBase✅ 初始化基础框架完成 time: ${DateTime.now()}', name: _logName);
}

/// 初始化App框架，同意协议后
///
/// 1、首次启动时间（仅一次初始化）
/// 2、获取包信息
/// 3、设备信息
/// 4、Dio初始化
/// 5、各类管理Manager初始化
/// 6、三方SDK初始化
Future<void> initApp() async {
  final agreedProtocol =
      PreferencesManager.instance.getBool(PreferencesKeys.agreedAppProtocol) ??
          false;
  if (!agreedProtocol) {
    log('未同意App协议⚠️ time: ${DateTime.now()}', name: _logName);
    return;
  }

  // 设置首次启动时间
  FirstLaunchManager.instance.setAppFirstLaunch();

  // 获取App信息
  await AppInfoManager.instance.init();
  final appInfo = AppInfoManager.instance.appInfoModel;

  // 初始化Dio
  final apiClient = ApiClient(
    Dio(BaseOptions(validateStatus: (_) => true))
      ..interceptors.add(RequestInterceptor(appInfo: appInfo!))
      ..interceptors.add(NetLogInterceptor()),
    baseUrl: kDebugMode ? AppDefine.kTestBaseURL : AppDefine.kBaseURL,
  );

  // 单例注入
  getIt.registerSingleton<ApiClient>(apiClient);

  log('initApp✅ App基础环境初始化完成time: ${DateTime.now()}', name: _logName);

  return;
}
