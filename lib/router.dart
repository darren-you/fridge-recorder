import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutternow/managers/protocol_manager.dart';
import 'package:flutternow/modules/home/ui/home_page.dart';
import 'package:flutternow/modules/login/login.dart';
import 'package:go_router/go_router.dart';
import 'package:flutternow/modules/protocols/ui/app_protocol_page.dart';

part 'router.g.dart';

/// 自定义路由观察者
final routeObserver = RouteObserver<PageRoute>();

/// App隐私协议
@TypedGoRoute<AppProtocolRoute>(path: '/appprotocol')
class AppProtocolRoute extends GoRouteData {
  const AppProtocolRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoPage(child: AppProtocolPage());
  }
}

/// 首页
@TypedGoRoute<MainRoute>(path: '/home')
class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoPage(child: HomePage());
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (!ProtocolManager.instance.agreedAppProtocolStatus()) {
      return '/appprotocol';
    }
    return null;
  }
}

/// 账号密码登录页
@TypedGoRoute<AccoutLoginRoute>(path: '/accout')
class AccoutLoginRoute extends GoRouteData {
  const AccoutLoginRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoPage(
      child: AccountLoginPage(),
    );
  }
}
