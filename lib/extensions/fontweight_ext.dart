import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutternow/app.dart';

/// 字重支持判断扩展
extension FontWeightExt on FontWeight {
  static get medium {
    return isFontWeigthSupportW500 ? FontWeight.w500 : FontWeight.bold;
  }

  static get bold {
    return FontWeight.bold;
  }

  /// 字重支持判断初始化
  static void getFontWeigthSupport() async {
    if (Platform.isIOS) {
      isFontWeigthSupportW500 = true;
    } else if (Platform.isAndroid) {
      try {
        final w400 = await _getImage(const TextStyle(
            fontSize: 10, fontWeight: FontWeight.w400, color: Colors.red));
        final w500 = await _getImage(const TextStyle(
            fontSize: 10, fontWeight: FontWeight.w500, color: Colors.red));
        isFontWeigthSupportW500 = !listEquals(w400, w500);
        log('字重支持判断完毕，Medium = $isFontWeigthSupportW500', name: 'Debug');
      } catch (e) {
        log('字重支持判断出错：$e', name: 'Debug');
      }
    }
  }

  // 使用Painter使用不同字重绘制图片，转换为byte比较
  static Future<Uint8List?> _getImage(TextStyle style) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '一',
        style: style,
      ),
      maxLines: 1,
    )..layout();
    painter.paint(canvas, Offset.zero);
    final picture = recorder.endRecording();
    final image = picture.toImageSync(10, 10);
    final bytes = await image.toByteData();
    return bytes?.buffer.asUint8List();
  }
}
