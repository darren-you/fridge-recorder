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
      title: '鲜存管家',
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
        child = botToastBuilder(context, child);
        return child;
      },
    );
  }
}
