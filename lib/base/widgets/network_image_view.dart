import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NetworkImageView extends StatelessWidget {
  const NetworkImageView({
    super.key,
    required this.url,
    this.fit,
    this.width,
    this.height,
    this.placeholder,
    this.alignment,
    this.scale = 1,
    this.gaplessPlayback = false,
  });

  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Alignment? alignment;
  final double scale;
  final bool gaplessPlayback;

  @override
  Widget build(BuildContext context) {
    Widget placeholder = this.placeholder ??
        Container(
          width: width,
          height: height,
          color: Colors.transparent,
        );
    if (url.isEmpty || Uri.tryParse(url) == null) {
      return SizedBox(
        width: width,
        height: height,
        child: placeholder,
      );
    }

    if (width == null && height == null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          double? w;
          double? h;
          if (constraints.maxWidth.isFinite) w = constraints.maxWidth;
          if (constraints.maxHeight.isFinite) h = constraints.maxHeight;
          return _NetworkImage(
            url: url,
            scale: scale,
            fit: fit,
            width: w,
            height: h,
            placeholder: placeholder,
            alignment: alignment,
          );
        },
      );
    }
    return _NetworkImage(
      url: url,
      scale: scale,
      fit: fit,
      width: width,
      height: height,
      placeholder: placeholder,
      alignment: alignment,
      gaplessPlayback: gaplessPlayback,
    );
  }
}

class _NetworkImage extends StatelessWidget {
  const _NetworkImage({
    required this.url,
    required this.scale,
    this.fit,
    this.width,
    this.height,
    this.placeholder,
    this.alignment,
    this.gaplessPlayback = false,
  });

  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Alignment? alignment;
  final double scale;
  final bool gaplessPlayback;

  @override
  Widget build(BuildContext context) {
    int? cacheWidth;
    int? cacheHeight;

    if (width != null) {
      cacheWidth =
          (width! * MediaQuery.devicePixelRatioOf(context) * scale).toInt();
    }
    if (height != null) {
      cacheHeight =
          (height! * MediaQuery.devicePixelRatioOf(context) * scale).toInt();
    }

    ImageProvider<Object> imageProvider = ExtendedNetworkImageProvider(
      url,
      scale: scale,
      cache: true,
      retries: 3,
      timeRetry: const Duration(milliseconds: 100),
    );
    if (cacheWidth != null || cacheHeight != null) {
      imageProvider = ResizeImage(
        imageProvider,
        width: cacheWidth,
        height: cacheHeight,
        policy: ResizeImagePolicy.fit,
      );
    }

    return Image(
      image: imageProvider,
      fit: fit,
      width: width,
      height: height,
      alignment: alignment ?? Alignment.center,
      gaplessPlayback: gaplessPlayback,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null) {
          return placeholder ?? const SizedBox();
        }
        return child;
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) {
          return child;
        }
        return placeholder ?? const SizedBox();
      },
      errorBuilder: (context, error, stackTrace) {
        log(error.toString(), name: 'NetWorkImage');
        return placeholder ?? const SizedBox();
      },
    );
  }
}
