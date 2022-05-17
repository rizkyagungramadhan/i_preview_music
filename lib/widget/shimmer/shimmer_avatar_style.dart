import 'package:flutter/material.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/18/2022.


class ShimmerAvatarStyle {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final bool? randomWidth;
  final double? minWidth;
  final double? maxWidth;
  final bool? randomHeight;
  final double? minHeight;
  final double? maxHeight;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;

  const ShimmerAvatarStyle({
    this.width = 48,
    this.height = 48,
    this.padding = const EdgeInsets.all(0),
    this.randomWidth,
    this.minWidth,
    this.maxWidth,
    this.randomHeight,
    this.minHeight,
    this.maxHeight,
    this.shape = BoxShape.rectangle,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  })  : assert(minWidth == null ||
      (minWidth > 0 && (maxWidth == null || maxWidth > minWidth))),
        assert(maxWidth == null ||
            (maxWidth > 0 && (minWidth == null || minWidth < maxWidth))),
        assert(minHeight == null ||
            (minHeight > 0 && (maxHeight == null || maxHeight > minHeight))),
        assert(maxHeight == null ||
            (maxHeight > 0 && (minHeight == null || minHeight < maxHeight)));
}
