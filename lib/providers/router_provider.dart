import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutternow/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    routes: $appRoutes,
    initialLocation: '/home',
    observers: [
      // 注册 bot_toast 路由观察
      BotToastNavigatorObserver(),
      // 自定义路由观察
      routeObserver,
    ],
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const SizedBox(),
    redirect: (context, state) {
      return null;
    },
  );
}
