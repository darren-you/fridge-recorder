import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutternow/app.dart';
import 'package:flutternow/base/base.dart';
import 'package:flutternow/network/api_client.dart';
import 'package:flutternow/providers/app_user_provider.dart';
import 'package:flutternow/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountLoginPage extends HookConsumerWidget {
  const AccountLoginPage({super.key});

  void login(BuildContext context, WidgetRef ref, String username,
      String password, ValueNotifier<String> loginResult) async {
    if (username.isEmpty) {
      BotToast.showText(text: '请输入账号');
      return;
    }
    if (password.isEmpty) {
      BotToast.showText(text: '请输入密码');
      return;
    }
    try {
      BotToast.showLoading();
      final appUserModel = (await getIt<ApiClient>()
              .loginByAccount(username: username, password: password))
          .data!;
      loginResult.value = appUserModel.toJson().toString();
      BotToast.showText(text: '欢迎👋: ${appUserModel.username}');
      ref.read(appUserProvider.notifier).save(appUserModel);
      BotToast.closeAllLoading();
    } on DioException catch (e) {
      loginResult.value = e.message ?? '';
      BotToast.closeAllLoading();
      BotToast.showText(text: '${e.message}');
      log('登录错误: ${e.message} time: ${DateTime.now()}', name: 'login');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final passController = TextEditingController();
    final loginResult = useState('');
    final userProfile = useState('');

    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      appBar: MAppBar(),
      body: Container(
        // color: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 64)),
            Text('账号'),
            const Padding(padding: EdgeInsets.only(bottom: 4)),
            CupertinoTextField(
              controller: nameController,
              style: TextStyle(color: context.appColors.text1),
            ),
            const Padding(padding: EdgeInsets.only(top: 16)),
            Text('密码'),
            const Padding(padding: EdgeInsets.only(bottom: 4)),
            CupertinoTextField(
              controller: passController,
              style: TextStyle(color: context.appColors.text1),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 32)),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomContainer(
                borderRadius: BorderRadius.circular(50),
                duration: Duration(milliseconds: 160),
                scaleValue: 0.99,
                onTap: () async {
                  try {
                    login(context, ref, nameController.text,
                        passController.text, loginResult);
                  } on DioException catch (e) {
                    loginResult.value = 'msg: ${e.message}';
                  }
                },
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '登录',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 16)),
            ValueListenableBuilder(
              valueListenable: loginResult,
              builder: (context, value, child) {
                return Text(value);
              },
            ),

            // 获取用户信息
            const Padding(padding: EdgeInsets.only(top: 32)),
            Text('获取用户信息:'),
            const Padding(padding: EdgeInsets.only(bottom: 16)),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomContainer(
                borderRadius: BorderRadius.circular(50),
                duration: Duration(milliseconds: 160),
                scaleValue: 0.99,
                onTap: () async {
                  try {
                    userProfile.value =
                        (await getIt<ApiClient>().getCurrentUser())
                            .data!
                            .toJson()
                            .toString();
                  } on DioException catch (e) {
                    userProfile.value = 'msg: ${e.message}';
                  }
                },
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '获取',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 16)),
            ValueListenableBuilder(
              valueListenable: userProfile,
              builder: (context, value, child) {
                return Text(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
