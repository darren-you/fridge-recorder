import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutternow/app.dart';
import 'package:flutternow/base/base.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UiExamplePage extends ConsumerWidget {
  const UiExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MAppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        title: 'UI',
        enabledBackdrop: true,
      ),
      backgroundColor: Colors.grey.withValues(alpha: 0.4),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.grey,
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
      _menuItem('UI示例', () {
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
