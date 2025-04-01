import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutternow/theme.dart';

class MAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MAppBar({
    super.key,
    this.child,
    this.backgroundColor,
    this.systemOverlayStyle,
    this.enabledBackdrop = true,
  });

  final Widget? child;
  final Color? backgroundColor;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool enabledBackdrop;

  @override
  Widget build(BuildContext context) {
    Widget appBar = AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemOverlayStyle ?? kSystemUiOverlayStyle,
      child: Container(
        color: backgroundColor ?? context.appColors.appBar,
        child: SafeArea(
          bottom: false,
          child: Container(
            height: 55,
            alignment: Alignment.center,
            child: child ?? const SizedBox(),
          ),
        ),
      ),
    );

    if (enabledBackdrop) {
      appBar = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: appBar,
        ),
      );
    }

    return appBar;
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
