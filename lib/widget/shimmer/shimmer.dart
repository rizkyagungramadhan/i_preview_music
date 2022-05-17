import 'package:flutter/material.dart';
import 'package:i_preview_music/widget/shimmer/shimmer_state.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/18/2022.


class Shimmer extends InheritedWidget {
  final ShimmerState shimmer;
  const Shimmer({
    Key? key,
    required Widget child,
    required this.shimmer,
  }) : super(key: key, child: child);

  static ShimmerState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Shimmer>()?.shimmer;

  @override
  bool updateShouldNotify(Shimmer oldWidget) => shimmer != oldWidget.shimmer;
}

class ShimmerWidget extends StatefulWidget {
  // static ShimmerState? of(BuildContext context) {
  //   return context.findAncestorStateOfType<ShimmerState>();
  // }

  const ShimmerWidget({
    Key? key,
    this.shimmerGradient,
    this.darkShimmerGradient,
    this.themeMode,
    this.duration,
    this.child,
  }) : super(key: key);

  final LinearGradient? shimmerGradient;
  final LinearGradient? darkShimmerGradient;
  final ThemeMode? themeMode;
  final Duration? duration;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

