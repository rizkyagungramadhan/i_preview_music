import 'dart:math';

import 'package:flutter/material.dart';
import 'package:i_preview_music/widget/shimmer/shimmer_avatar_style.dart';
import 'package:i_preview_music/widget/shimmer/shimmer_item.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/18/2022.


class ShimmerAvatar extends StatelessWidget {
  final ShimmerAvatarStyle style;
  const ShimmerAvatar({Key? key, this.style = const ShimmerAvatarStyle()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerItem(
      child: Padding(
        padding: style.padding,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: ((style.randomWidth != null && style.randomWidth!) ||
                  (style.randomWidth == null &&
                      (style.minWidth != null && style.maxWidth != null)))
                  ? doubleInRange(
                  style.minWidth ??
                      ((style.maxWidth ?? constraints.maxWidth) / 3),
                  style.maxWidth ?? constraints.maxWidth)
                  : style.width,
              height: ((style.randomHeight != null && style.randomHeight!) ||
                  (style.randomHeight == null &&
                      (style.minHeight != null && style.maxHeight != null)))
                  ? doubleInRange(
                  style.minHeight ??
                      ((style.maxHeight ?? constraints.maxHeight) / 3),
                  style.maxHeight ?? constraints.maxHeight)
                  : style.height,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                shape: style.shape,
                borderRadius:
                style.shape != BoxShape.circle ? style.borderRadius : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

double doubleInRange(num start, num end) =>
    Random().nextDouble() * (end - start) + start;

