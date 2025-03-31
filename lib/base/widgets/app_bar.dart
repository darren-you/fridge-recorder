import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutternow/extensions/fontweight_ext.dart';
import 'package:flutternow/theme.dart';

import 'app_bar_back_button.dart';

class MAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.leadingWidth,
    this.actions,
    this.backgroundColor,
    this.systemOverlayStyle,
    this.overlay,
    this.enabledBackdrop = true,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Widget? overlay;
  final bool enabledBackdrop;

  @override
  Widget build(BuildContext context) {
    Widget child = AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemOverlayStyle ?? kSystemUiOverlayStyle,
      child: Container(
        color: backgroundColor ?? context.appColors.appBar,
        child: SafeArea(
          bottom: false,
          child: Container(
            height: 55,
            alignment: Alignment.center,
            child: NavigationToolbar(
              leading: leading ?? _buildLeading(context),
              trailing: actions != null
                  ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
                  : null,
              middle: titleWidget ??
                  Text(
                    title ?? '',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeightExt.medium,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );

    if (overlay != null) {
      child = Stack(
        children: [
          child,
          Positioned.fill(child: overlay!),
        ],
      );
    }

    if (enabledBackdrop) {
      child = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: child,
        ),
      );
    }

    return child;
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;
    final route = ModalRoute.of(context);
    if (route is PageRoute && (route.canPop || route.fullscreenDialog)) {
      return AppBarBackButton(fullscreen: route.fullscreenDialog);
    }
    return null;
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
