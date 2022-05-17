

import 'package:flutter/material.dart';
import 'package:i_preview_music/widget/tapdebouncer/debouncer_handler.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/18/2022.


class TapDebouncer extends StatefulWidget {
  const TapDebouncer({
    Key? key,
    required this.builder,
    this.waitBuilder,
    this.onTap,
    this.cooldown,
  }) : super(key: key);

  /// Pass this time to constructor if want to allow only one tap and
  /// then disable button forever
  static const Duration kNeverCooldown = Duration(days: 100000000);

  /// Main button builder function
  /// context is current context
  /// onTap is function to pass to SomeButton or InkWell
  final Widget Function(BuildContext context, Future<void> Function()? onTap) builder;

  /// Waiting button builder function
  /// context is current context
  /// child is widget returning from builder method with onTap equal null
  final Widget Function(BuildContext context, Widget child)? waitBuilder;

  /// Function to call on tap
  final Future<void> Function()? onTap;

  /// Cooldown duration - delay after onTap executed (successfully or not)
  final Duration? cooldown;

  @override
  _TapDebouncerState createState() => _TapDebouncerState();
}

class _TapDebouncerState extends State<TapDebouncer> {
  final DebouncerHandler _tapDebouncerHandler = DebouncerHandler();

  @override
  void dispose() {
    _tapDebouncerHandler.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _tapDebouncerHandler.busyStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasError) {
          throw StateError('_tapDebouncerHandler.busy has error=${snapshot.error}');
        }

        final bool isBusy = snapshot.data!;

        if (!isBusy) {
          return widget.builder(
            context,
            widget.onTap == null
                ? null
                : () async {
              await _tapDebouncerHandler.onTap(
                    () async {
                  await widget.onTap!();

                  if (widget.cooldown != null) {
                    await Future<void>.delayed(widget.cooldown!);
                  }
                },
              );
            },
          );
        }

        final Widget disabledChild = widget.builder(context, null);

        if (widget.waitBuilder == null) {
          return disabledChild;
        } else {
          return widget.waitBuilder!(context, disabledChild);
        }
      },
    );
  }
}

