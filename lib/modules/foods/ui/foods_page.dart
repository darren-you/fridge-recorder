import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutternow/app.dart';
import 'package:flutternow/base/base.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FoodsPage extends ConsumerWidget {
  const FoodsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MAppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        enabledBackdrop: true,
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(),
              ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
              ),
              Text(
                'DarrenYou 的冰箱',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Expanded(child: SizedBox()),
              SvgPicture.asset(
                Assets.svg.iconMessage,
                width: 20,
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 16),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.withValues(alpha: 0.4),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.grey,
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
