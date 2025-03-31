import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutternow/app.dart';
import 'package:flutternow/providers/router_provider.dart';
import 'package:flutternow/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initBase();
  await initApp();

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final botToastBuilder = BotToastInit();

    return MaterialApp.router(
      title: 'Flutter Now',
      routerConfig: router,
      theme: themeData,
      darkTheme: themeData,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
        overscroll: true,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),
      ],
      builder: (context, child) {
        /*
        1. 参数含义
            context : 确实是整个应用的 BuildContext，包含了整个应用的上下文信息
            child : 是 MaterialApp 构建的整个应用的 widget 树
        2. 处理过程
          botToastBuilder(context, child) 会：
          接收整个应用的 context 和 widget 树
          在原有的 widget 树中注入 Overlay 系统
          这个 Overlay 会成为 widget 树的一部分，但位于最顶层
        3. 返回结果
          返回的 child 确实是已经注入了 Overlay 支持的完整 widget 树
          这个修改后的 widget 树包含了所有原有的 UI 元素，plus：
          Toast 显示所需的 Overlay 支持
          Toast 管理器
          动画支持等
         */
        child = botToastBuilder(context, child);
        return child;
      },
    );
  }
}
