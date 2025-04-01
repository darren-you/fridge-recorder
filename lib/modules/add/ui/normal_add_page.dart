import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutternow/app.dart';
import 'package:flutternow/base/base.dart';
import 'package:flutternow/managers/protocol_manager.dart';
import 'package:flutternow/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NormalAddPage extends ConsumerWidget {
  const NormalAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MAppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
      ),
      backgroundColor: Colors.grey.withValues(alpha: 0.4),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: _buildFunMenuList(context).length,
          itemBuilder: (context, index) {
            return _buildFunMenuList(context)[index];
          },
        ),
      ),
    );
  }

  List<Widget> _buildFunMenuList(BuildContext context) {
    return [
      _menuItem('清除隐私协议状态', () {
        ProtocolManager.instance.removeAgreedAppProtocol();
        BotToast.showText(text: '清除成功✅');
      }),
      _menuItem('游客登陆', () {
        BotToast.showText(text: '待实现');
      }),
      _menuItem('账号登陆', () {
        AccoutLoginRoute().push(context);
      }),
      _menuItem('验证码登陆', () {
        BotToast.showText(text: '待实现');
      }),
      _menuItem('微信登陆', () {
        BotToast.showText(text: '待实现');
      }),
      _menuItem('QQ登陆', () {
        BotToast.showText(text: '待实现');
      }),
      _menuItem('资料更新', () {
        BotToast.showText(text: '待实现');
      }),
      _menuItem('退出登陆', () {
        BotToast.showText(text: '待实现');
      }, nameColor: Colors.red),
      _menuItem('微信支付', () {
        BotToast.showText(text: '待实现');
      }),
      _menuItem('支付宝支付', () {
        BotToast.showText(text: '待实现');
      }),
    ];
  }

  Widget _menuItem(String name, VoidCallback onTap, {Color? nameColor}) {
    return CustomContainer(
      borderRadius: BorderRadius.circular(12),
      duration: Duration(milliseconds: 160),
      scaleValue: 0.99,
      onTap: onTap,
      margin: const EdgeInsets.only(top: 16),
      child: Container(
        width: double.infinity,
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              name,
              style: TextStyle(color: nameColor),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            SvgPicture.asset(
              Assets.svg.iconRight,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            )
          ],
        ),
      ),
    );
  }
}
