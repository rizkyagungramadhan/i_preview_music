import 'dart:ui';

import 'package:flutter/material.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.

extension WidgetExt on Widget {
  /// Doc : Add [SingleChildScrollView] into any widget & make it vertically scrollable.
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 22:27.
  Widget asScrollable() => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: this,
      );

  /// Doc : Make widget as transparent as Glass.
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 22:27.
  Widget asGlass({
    double blurX = 10,
    double blurY = 10,
    Color tintColor = Colors.white,
    bool frosted = true,
    BorderRadius? clipBorderRadius = BorderRadius.zero,
    Clip clipBehaviour = Clip.antiAlias,
    TileMode tileMode = TileMode.clamp,
    CustomClipper<RRect>? clipper,
  }) {
    return ClipRRect(
      clipper: clipper,
      clipBehavior: clipBehaviour,
      borderRadius: clipBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurX,
          sigmaY: blurY,
          tileMode: tileMode,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: (tintColor != Colors.transparent)
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      tintColor.withOpacity(0.1),
                      tintColor.withOpacity(0.08),
                    ],
                  )
                : null,
          ),
          child: this,
        ),
      ),
    );
  }
}
