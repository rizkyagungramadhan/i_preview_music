import 'package:flutter/material.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/18/2022.


class ShimmerTheme extends InheritedWidget {
  final LinearGradient? shimmerGradient;
  final LinearGradient? darkShimmerGradient;
  final ThemeMode? themeMode;

  const ShimmerTheme({
    Key? key,
    required Widget child,
    this.shimmerGradient,
    this.darkShimmerGradient,
    this.themeMode,
  }) : super(key: key, child: child);

  static ShimmerTheme? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ShimmerTheme>();

  @override
  bool updateShouldNotify(ShimmerTheme oldWidget) =>
      oldWidget.themeMode != themeMode ||
          oldWidget.shimmerGradient != shimmerGradient ||
          oldWidget.darkShimmerGradient != darkShimmerGradient;
}
