import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutternow/app.dart';
import 'package:flutternow/managers/protocol_manager.dart';
import 'package:flutternow/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// App同意协议界面
class AppProtocolPage extends HookConsumerWidget {
  const AppProtocolPage({super.key});

  // 不同意协议
  void _notAgree() {
    ProtocolManager.instance.removeAgreedAppProtocol();
    exit(1);
  }

  // 同意协议
  Future<void> _agreeProtocol(BuildContext context) async {
    ProtocolManager.instance.setAgreedAppProtocol();
    await initApp();
    if (context.mounted) MainRoute().go(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.8),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 36, vertical: 200),
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                        'agree: ${ProtocolManager.instance.agreedAppProtocolStatus()}'),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _notAgree,
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '不同意',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _agreeProtocol(context),
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.only(right: 16, top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text('同意'),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
