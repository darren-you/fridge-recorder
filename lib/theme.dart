import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutternow/base/base.dart';

/// 设置App状态栏、导航栏颜色
const kSystemUiOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarContrastEnforced: false,
);

/// 扩展Theme自定义AppColors
/// 通过BuildContext对象.appColors调用
class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color secondary;
  final Color secondary1;

  final Color appBar;

  final Color mainBackground;

  final Color mainBackgroundContrastingColor;

  final Color cardBackground;

  final Color divider;

  final Color text1;

  final Color text2;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.secondary1,
    required this.appBar,
    required this.mainBackground,
    required this.mainBackgroundContrastingColor,
    required this.cardBackground,
    required this.divider,
    required this.text1,
    required this.text2,
  });

  @override
  ThemeExtension<AppColors> copyWith() {
    return AppColors(
      primary: primary,
      secondary: secondary,
      secondary1: secondary1,
      appBar: appBar,
      mainBackground: mainBackground,
      mainBackgroundContrastingColor: mainBackgroundContrastingColor,
      cardBackground: cardBackground,
      divider: divider,
      text1: text1,
      text2: text2,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    if (other == null) return this;
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      secondary1: Color.lerp(secondary1, other.secondary1, t) ?? secondary1,
      appBar: Color.lerp(appBar, other.appBar, t) ?? appBar,
      mainBackground:
          Color.lerp(mainBackground, other.mainBackground, t) ?? mainBackground,
      mainBackgroundContrastingColor: Color.lerp(mainBackgroundContrastingColor,
              other.mainBackgroundContrastingColor, t) ??
          mainBackgroundContrastingColor,
      cardBackground:
          Color.lerp(cardBackground, other.cardBackground, t) ?? cardBackground,
      divider: Color.lerp(divider, other.divider, t) ?? divider,
      text1: Color.lerp(text1, other.text1, t) ?? text1,
      text2: Color.lerp(text1, other.text2, t) ?? text2,
    );
  }
}

/// 扩展Theme自定义AppStyle
/// 通过BuildContext对象.appStyles调用
class AppStyles extends ThemeExtension<AppStyles> {
  AppStyles({
    required this.mainGradient,
    required this.primaryButtonDecoration,
  });

  final Gradient mainGradient;
  final Decoration primaryButtonDecoration;

  @override
  AppStyles copyWith() {
    return AppStyles(
      mainGradient: mainGradient,
      primaryButtonDecoration: primaryButtonDecoration,
    );
  }

  @override
  ThemeExtension<AppStyles> lerp(
      covariant ThemeExtension<AppStyles>? other, double t) {
    if (other == null) return this;
    if (other is! AppStyles) {
      return this;
    }

    return AppStyles(
      mainGradient:
          Gradient.lerp(mainGradient, other.mainGradient, t) ?? mainGradient,
      primaryButtonDecoration: Decoration.lerp(
              primaryButtonDecoration, other.primaryButtonDecoration, t) ??
          primaryButtonDecoration,
    );
  }
}

/// 扩展定义AppStyles
final _appStyles = AppStyles(
  mainGradient: LinearGradient(
    colors: [
      _appColors.primary,
      _appColors.secondary,
    ],
    begin: const Alignment(0.1, -2),
    end: const Alignment(-0.1, 2),
  ),
  primaryButtonDecoration: ShapeDecoration(
    shape: const StadiumBorder(),
    gradient: LinearGradient(
      colors: [
        _appColors.primary,
        _appColors.secondary,
      ],
      begin: const Alignment(0.1, -2),
      end: const Alignment(-0.1, 2),
    ),
  ),
);

/// 扩展定义AppColors
const _appColors = AppColors(
  primary: Color.fromARGB(255, 40, 171, 241),
  secondary: Color(0xFFEA6900),
  secondary1: Color(0xFF5CF2C5),
  appBar: Color(0xFFFFFFFF),
  mainBackground: Color(0xFFFFFFFF),
  mainBackgroundContrastingColor: Color(0xFF212121),
  cardBackground: Color(0xFF161616),
  divider: Color(0xFF393939),
  text1: Color(0xFF333333),
  text2: Color.fromARGB(255, 97, 97, 97),
);

/// 设置BuildContext扩展方法
/// 使得context可以访问到appColors、appStyles
extension AppThemeExtension on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  AppStyles get appStyles => Theme.of(this).extension<AppStyles>()!;
}

/// 从底部滑入的动画效果
Widget bottomSlideAnimation(
  BuildContext context,
  Animation<double> animation,
  Widget child,
) {
  final slideAnimation =
      Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
          .chain(CurveTween(curve: SpringCurve.slow))
          .animate(animation);
  return Align(
    alignment: Alignment.bottomCenter,
    child: SlideTransition(
      position: slideAnimation,
      child: child,
    ),
  );
}

/// 弹出式淡入淡出动画效果
Widget popFadeAnimation(
    BuildContext context, Animation<double> animation, Widget child) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      if (animation.status == AnimationStatus.reverse) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(animation),
          child: ScaleTransition(
            scale: Tween<double>(begin: 1, end: 1).animate(animation),
            child: child,
          ),
        );
      }
      Animation<double> curve = CurvedAnimation(
        parent: animation,
        curve: SpringCurve.slow,
      );
      final fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curve);
      final scaleAnimation = Tween<double>(begin: 1.1, end: 1).animate(curve);
      return FadeTransition(
        opacity: fadeAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: child,
        ),
      );
    },
    child: child,
  );
}

/// 定义App主题样式
final themeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: 'HarmonyOS Sans SC',
  colorScheme: ColorScheme.light(
    primary: _appColors.primary,
  ),
  primaryColor: _appColors.primary,
  fontFamilyFallback: const ['HarmonyOS Sans SC'],
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: _appColors.appBar,
    systemOverlayStyle: kSystemUiOverlayStyle,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamilyFallback: ['HarmonyOS Sans SC'],
      letterSpacing: 0,
    ),
  ),
  textTheme: TextTheme(
    // 大部分地方的文字颜色
    bodyMedium: TextStyle(
      color: _appColors.text1,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
    ),
    // 大部分地方的文字颜色
    titleMedium: TextStyle(
      color: _appColors.text1,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
    ),
  ),
  cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: _appColors.primary,
    textTheme: const CupertinoTextThemeData(
      textStyle: TextStyle(
        // 默认不为0
        letterSpacing: 0,
        fontFamilyFallback: ['HarmonyOS Sans SC'],
      ),
    ),
  ),
  dividerTheme: DividerThemeData(
    color: _appColors.divider,
    thickness: 0.5,
  ),
  dividerColor: _appColors.divider,
  scaffoldBackgroundColor: _appColors.mainBackground,
  tabBarTheme: const TabBarTheme(
    dividerColor: Colors.transparent,
  ),
  extensions: [
    _appColors,
    _appStyles,
  ],
);
