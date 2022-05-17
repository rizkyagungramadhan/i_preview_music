import 'package:flutter/material.dart';
import 'package:i_preview_music/widget/shimmer/shimmer.dart';
import 'package:i_preview_music/widget/shimmer/shimmer_theme.dart';

/// Created by rizkyagungramadhan@gmail.com 
/// on 5/18/2022.

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFD6D6E4),
    Color(0xFFD1D1DF),
    Color(0xFFD6D6E4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.0,
    0.3,
    0.5,
    0.7,
    1,
  ],
  begin: Alignment(-2.4, -0.2),
  end: Alignment(2.4, 0.2),
  tileMode: TileMode.clamp,
);

const _darkShimmerGradient = LinearGradient(
  colors: [
    Color(0xFF222222),
    Color(0xFF242424),
    Color(0xFF2B2B2B),
    Color(0xFF242424),
    Color(0xFF222222),
  ],
  stops: [
    0.0,
    0.2,
    0.5,
    0.8,
    1,
  ],
  begin: Alignment(-2.4, -0.2),
  end: Alignment(2.4, 0.2),
  tileMode: TileMode.clamp,
);
class ShimmerState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  // late LinearGradient _linearGradient;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((_) => _setGradient());
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(
          min: -2.0,
          max: 2,
          period: widget.duration ?? const Duration(milliseconds: 1000));
  }

  // _setGradient() {
  //   _linearGradient = widget.linearGradient ??
  //       ShimmerTheme.of(context)?.shimmerGradient ??
  //       shimmerGradient;
  // }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  ThemeMode get _appThemeMode => Theme.of(context).brightness == Brightness.dark
      ? ThemeMode.dark
      : ThemeMode.light;

  @visibleForTesting
  LinearGradient get gradient => ((widget.themeMode ??
      ShimmerTheme.of(context)?.themeMode ??
      _appThemeMode) ==
      ThemeMode.dark)
      ? _darkGradient
      : _lightGradient;

  LinearGradient get _lightGradient =>
      widget.shimmerGradient ??
          ShimmerTheme.of(context)?.shimmerGradient ??
          _shimmerGradient;

  LinearGradient get _darkGradient =>
      widget.darkShimmerGradient ??
          ShimmerTheme.of(context)?.darkShimmerGradient ??
          _darkShimmerGradient;

  LinearGradient get currentGradient => LinearGradient(
    colors: gradient.colors,
    stops: gradient.stops,
    begin: gradient.begin,
    end: gradient.end,
    transform:
    _SlidingGradientTransform(slidePercent: _shimmerController.value),
  );

  bool get isSized => context.findRenderObject() != null
      ? (context.findRenderObject() as RenderBox).hasSize
      : false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child != null
        ? Shimmer(
      child: widget.child!,
      shimmer: this,
    )
        : const SizedBox();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

