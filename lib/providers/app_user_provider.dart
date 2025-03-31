import 'dart:convert';
import 'dart:developer';

import 'package:event_bus/event_bus.dart';
import 'package:flutternow/app.dart';
import 'package:flutternow/constants/prefrences_keys.dart';
import 'package:flutternow/eventbus/event_bus.dart';
import 'package:flutternow/managers/preferences_manager.dart';
import 'package:flutternow/models/app_user_model.dart';
import 'package:flutternow/network/api_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_user_provider.g.dart';

/// 从本地缓存中读取用户登陆信息
/// 将 JSON 数据解析为 AppUserModel 对象
AppUserModel? getUser() {
  final cacheUserInfoData =
      PreferencesManager.instance.getString(PreferencesKeys.userCacheInfo);
  if (cacheUserInfoData != null) {
    try {
      final jsonObj = jsonDecode(cacheUserInfoData);
      if (jsonObj is Map) {
        return AppUserModel.fromJson(Map<String, dynamic>.from(jsonObj));
      }
    } catch (e) {
      log('获取用户失败:$e time: ${DateTime.now()}', name: 'user');
    }
  }
  return null;
}

@Riverpod(keepAlive: true)
class AppUser extends _$AppUser {
  @override
  AppUserModel? build() {
    // 监听 token 过期事件
    final sub = getIt<EventBus>().on<UserTokenExpired>().listen((_) {
      delete();
    });

    // 在销毁时取消事件订阅
    ref.onDispose(() {
      sub.cancel();
    });

    // 返回本地缓存的用户信息
    return getUser();
  }

  Future<void> refresh() async {
    if (state == null) return;
    try {
      var user = (await getIt<ApiClient>().getCurrentUser()).data!;
      user = user.copyWith(accessToken: state!.accessToken);
      save(user);
      getIt<EventBus>().fire(UserUpdatedEvent());
    } catch (e) {
      log('刷新用户信息错误:$e time: ${DateTime.now()}', name: 'user');
    }
  }

  void save(AppUserModel? newValue) {
    PreferencesManager.instance
        .setString(PreferencesKeys.userLoginToken, newValue?.accessToken);
    PreferencesManager.instance.setString(PreferencesKeys.userCacheInfo,
        newValue == null ? null : jsonEncode(newValue.toJson()));

    final oldValue = state;
    state = newValue;
    if (oldValue != null && newValue == null) {
      getIt<EventBus>().fire(UserLogoutEvent());
    } else if (oldValue == null && newValue != null) {
      getIt<EventBus>().fire(UserLoginedEvent());
    }
  }

  /// 删除用户信息方法
  void delete() {
    save(null);
  }
}

@Riverpod(keepAlive: true)
bool isLogged(Ref ref) {
  return ref.watch(appUserProvider) != null;
}
