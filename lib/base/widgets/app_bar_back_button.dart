import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutternow/app.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
    this.fullscreen = false,
  });

  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    if (fullscreen) {
      return CupertinoButton(
        onPressed: () => Navigator.of(context).maybePop(),
        minSize: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SvgPicture.asset(
          Assets.svg.iconArrowdown,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
      );
    }
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: SvgPicture.asset(
        Assets.svg.iconNavback,
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
      ),
      onPressed: () {
        Navigator.of(context).maybePop();
      },
    );
  }
}
