import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutternow/app.dart';
import 'package:flutternow/base/widgets/network_image_view.dart';
import 'package:flutternow/providers/app_user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MinePage extends ConsumerWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQueryData = MediaQuery.of(context);
    var statusBarHeight = mediaQueryData.padding.top;
    final appUserNotifier = ref.watch(appUserProvider);

    return Scaffold(
      backgroundColor: Colors.grey.withValues(alpha: 0.4),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: statusBarHeight + 32,
                    color: Colors.white,
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 32, bottom: 64),
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: NetworkImageView(
                            url: appUserNotifier != null
                                ? appUserNotifier.avatar
                                : '',
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 32)),
                        SizedBox(
                          height: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 8)),
                              Text(
                                appUserNotifier != null
                                    ? appUserNotifier.username
                                    : '',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Text(
                                'Weixin ID: ${appUserNotifier != null ? appUserNotifier.username : ''}',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 8)),
                            ],
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        SizedBox(
                          height: 80,
                          child: Column(
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 14)),
                              SvgPicture.asset(
                                Assets.svg.iconBarcode,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Colors.black87, BlendMode.srcIn),
                              ),
                              const Expanded(child: SizedBox()),
                              SvgPicture.asset(
                                Assets.svg.iconRight,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Colors.grey, BlendMode.srcIn),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 8)),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
