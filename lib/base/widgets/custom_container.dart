import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomContainer extends HookWidget {
  final VoidCallback? onTap;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final Widget? child;
  final Duration duration;
  final Color? startColor;
  final Color? endColor;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final bool scale;
  final double scaleValue;
  final Clip clipBehavior;
  final bool bgAnim;
  final bool foreAnim;

  const CustomContainer({
    super.key,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.child,
    this.duration = const Duration(milliseconds: 50),
    this.startColor,
    this.endColor,
    this.color = Colors.white,
    this.margin,
    this.padding,
    this.borderRadius,
    this.scale = true,
    this.scaleValue = 0.98,
    this.clipBehavior = Clip.none,
    this.bgAnim = false,
    this.foreAnim = true,
  });

  @override
  Widget build(BuildContext context) {
    final animController = useAnimationController(duration: duration);
    final isPressed = useState(false);

    final scaleAnimation = useAnimation(
      Tween<double>(begin: 1.0, end: scaleValue).animate(
        CurvedAnimation(parent: animController, curve: Curves.decelerate),
      ),
    );

    final bgColorAnimation = useAnimation(
      ColorTween(
        begin: color == null
            ? startColor?.withValues(alpha: 1.0)
            : color?.withValues(alpha: 1.0),
        end: color == null
            ? endColor?.withValues(alpha: 0.8)
            : color?.withValues(alpha: 0.8),
      ).animate(
        CurvedAnimation(parent: animController, curve: Curves.decelerate),
      ),
    );

    final foreColorAnimation = useAnimation(
      ColorTween(
        begin: Colors.grey.withValues(alpha: 0.0),
        end: Colors.grey.withValues(alpha: 0.3),
      ).animate(
        CurvedAnimation(parent: animController, curve: Curves.decelerate),
      ),
    );

    void handleTapDown(TapDownDetails details) {
      isPressed.value = true;
      animController.forward();
      onTapDown?.call();
    }

    Future<void> handleTapUp(TapUpDetails details) async {
      if (isPressed.value) {
        await animController.animateTo(1.0);
        if (!context.mounted) return;
        await animController.reverse();
        if (!context.mounted) return;
        isPressed.value = false;
      } else {
        await animController.reverse();
      }

      onTapUp?.call();
      onTap?.call();
    }

    void handleTapCancel() {
      isPressed.value = false;
      animController.reverse();
    }

    return GestureDetector(
      onTapDown: handleTapDown,
      onTapUp: handleTapUp,
      onTapCancel: handleTapCancel,
      behavior: HitTestBehavior.translucent,
      child: Transform.scale(
        scale: scale ? scaleAnimation : 1.0,
        child: Container(
          margin: margin,
          padding: padding,
          clipBehavior: clipBehavior,
          decoration: BoxDecoration(
            color: bgAnim ? bgColorAnimation : color,
            borderRadius: borderRadius,
          ),
          foregroundDecoration: BoxDecoration(
            color: foreAnim ? foreColorAnimation : color,
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}
