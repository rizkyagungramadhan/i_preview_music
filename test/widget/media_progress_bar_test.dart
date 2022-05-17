import 'package:i_preview_music/widget/mediaprogressbar/media_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i_preview_music/widget/mediaprogressbar/thumb_drag_details.dart';
import 'package:i_preview_music/widget/mediaprogressbar/time_label_location.dart';
import 'package:i_preview_music/widget/mediaprogressbar/time_label_type.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/18/2022.


void main() {
  testWidgets('MediaProgressBar widget exists', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MediaProgressBar(
        progress: Duration.zero,
        total: Duration(minutes: 5),
      ),
    );

    final progressBarFinder = find.byType(MediaProgressBar);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('MediaProgressBar widget properties exists',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MediaProgressBar(
            progress: Duration.zero,
            total: const Duration(minutes: 5),
            buffered: const Duration(minutes: 1),
            onSeek: (duration) {},
            onDragStart: (ThumbDragDetails details) {},
            onDragUpdate: (ThumbDragDetails details) {},
            onDragEnd: () {},
            barHeight: 2.0,
            baseBarColor: const Color(0x00000000),
            progressBarColor: const Color(0x00000000),
            bufferedBarColor: const Color(0x00000000),
            thumbRadius: 20.0,
            thumbColor: const Color(0x00000000),
            thumbGlowColor: const Color(0x00000000),
            thumbGlowRadius: 50.0,
            thumbCanPaintOutsideBar: false,
            timeLabelLocation: TimeLabelLocation.sides,
            timeLabelType: TimeLabelType.remainingTime,
            timeLabelTextStyle: const TextStyle(color: Color(0x00000000)),
          ),
        );

        MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
        expect(mediaProgressBar, isNotNull);

        expect(mediaProgressBar.progress, Duration.zero);
        expect(mediaProgressBar.total, const Duration(minutes: 5));
        expect(mediaProgressBar.buffered, const Duration(minutes: 1));
        expect(mediaProgressBar.onSeek, isNotNull);
        expect(mediaProgressBar.barHeight, 2.0);
        expect(mediaProgressBar.baseBarColor, const Color(0x00000000));
        expect(mediaProgressBar.progressBarColor, const Color(0x00000000));
        expect(mediaProgressBar.bufferedBarColor, const Color(0x00000000));
        expect(mediaProgressBar.thumbRadius, 20.0);
        expect(mediaProgressBar.thumbColor, const Color(0x00000000));
        expect(mediaProgressBar.thumbGlowColor, const Color(0x00000000));
        expect(mediaProgressBar.thumbGlowRadius, 50.0);
        expect(mediaProgressBar.thumbCanPaintOutsideBar, false);
        expect(mediaProgressBar.timeLabelLocation, TimeLabelLocation.sides);
        expect(mediaProgressBar.timeLabelType, TimeLabelType.remainingTime);
        expect(mediaProgressBar.timeLabelTextStyle,
            const TextStyle(color: Color(0x00000000)));
        expect(mediaProgressBar.timeLabelPadding, 0.0);
      });

  testWidgets('TimeLabelLocation.below size correct',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const Center(
            child: MediaProgressBar(
              progress: Duration.zero,
              total: Duration(minutes: 5),
              timeLabelLocation: TimeLabelLocation.below,
            ),
          ),
        );

        MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
        expect(mediaProgressBar, isNotNull);

        final baseSize = tester.getSize(find.byType(MediaProgressBar));
        expect(baseSize.width, equals(800.0));
        expect(baseSize.height, equals(34.0));
      });

  testWidgets('TimeLabelLocation.above size correct',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const Center(
            child: MediaProgressBar(
              progress: Duration.zero,
              total: Duration(minutes: 5),
              timeLabelLocation: TimeLabelLocation.above,
            ),
          ),
        );

        MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
        expect(mediaProgressBar, isNotNull);

        final baseSize = tester.getSize(find.byType(MediaProgressBar));
        expect(baseSize.width, equals(800.0));
        expect(baseSize.height, equals(34.0));
      });

  testWidgets('TimeLabelLocation.sides size correct',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const Center(
            child: MediaProgressBar(
              progress: Duration.zero,
              total: Duration(minutes: 5),
              timeLabelLocation: TimeLabelLocation.sides,
            ),
          ),
        );

        MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
        expect(mediaProgressBar, isNotNull);

        final baseSize = tester.getSize(find.byType(MediaProgressBar));
        expect(baseSize.width, equals(800.0));
        expect(baseSize.height, equals(20.0));
      });

  testWidgets('TimeLabelLocation.none size correct',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const Center(
            child: MediaProgressBar(
              progress: Duration.zero,
              total: Duration(minutes: 5),
              timeLabelLocation: TimeLabelLocation.none,
            ),
          ),
        );

        MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
        expect(mediaProgressBar, isNotNull);

        final baseSize = tester.getSize(find.byType(MediaProgressBar));
        expect(baseSize.width, equals(800.0));
        expect(baseSize.height, equals(20.0));
      });

  testWidgets('MediaProgressBar default size is TimeLabelLocation.below',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const Center(
            child: MediaProgressBar(
              progress: Duration.zero,
              total: Duration(minutes: 5),
            ),
          ),
        );

        MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
        expect(mediaProgressBar, isNotNull);

        final baseSize = tester.getSize(find.byType(MediaProgressBar));
        expect(baseSize.width, equals(800.0));
        expect(baseSize.height, equals(34.0));
      });

  testWidgets('Changing the thumb radius changes the widget size',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const Center(
            child: MediaProgressBar(
              progress: Duration.zero,
              total: Duration(minutes: 5),
              thumbRadius: 30,
              timeLabelLocation: TimeLabelLocation.none,
            ),
          ),
        );

        MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
        expect(mediaProgressBar, isNotNull);

        final baseSize = tester.getSize(find.byType(MediaProgressBar));
        expect(baseSize.width, equals(800.0));
        expect(baseSize.height, equals(60.0));
      });

  testWidgets(
      'The height is the max of the font and thumb radius for TimeLabelLocation.sides',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const Center(
            child: MediaProgressBar(
              progress: Duration.zero,
              total: Duration(minutes: 5),
              thumbRadius: 5,
              timeLabelLocation: TimeLabelLocation.sides,
            ),
          ),
        );

        MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
        expect(mediaProgressBar, isNotNull);

        final baseSize = tester.getSize(find.byType(MediaProgressBar));
        expect(baseSize.width, equals(800.0));
        expect(baseSize.height, equals(14.0));
      });

  group('timeLabelPadding -', () {
    testWidgets('Size with timeLabelPadding is correct when labels below',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            const Center(
              child: MediaProgressBar(
                progress: Duration.zero,
                total: Duration(minutes: 5),
                timeLabelPadding: 10,
                timeLabelLocation: TimeLabelLocation.below,
              ),
            ),
          );

          MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
          expect(mediaProgressBar, isNotNull);

          final baseSize = tester.getSize(find.byType(MediaProgressBar));
          expect(baseSize.width, equals(800.0));
          expect(baseSize.height, equals(44.0));
        });

    testWidgets('Size with timeLabelPadding is correct when labels above',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            const Center(
              child: MediaProgressBar(
                progress: Duration.zero,
                total: Duration(minutes: 5),
                timeLabelPadding: 10,
                timeLabelLocation: TimeLabelLocation.above,
              ),
            ),
          );

          MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
          expect(mediaProgressBar, isNotNull);

          final baseSize = tester.getSize(find.byType(MediaProgressBar));
          expect(baseSize.width, equals(800.0));
          expect(baseSize.height, equals(44.0));
        });

    testWidgets('Size with timeLabelPadding is correct when labels on sides',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            const Center(
              child: MediaProgressBar(
                progress: Duration.zero,
                total: Duration(minutes: 5),
                timeLabelPadding: 10,
                timeLabelLocation: TimeLabelLocation.sides,
              ),
            ),
          );

          MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
          expect(mediaProgressBar, isNotNull);

          final baseSize = tester.getSize(find.byType(MediaProgressBar));
          expect(baseSize.width, equals(800.0));
          expect(baseSize.height, equals(20.0));
        });

    testWidgets('Size with timeLabelPadding is correct when no labels',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            const Center(
              child: MediaProgressBar(
                progress: Duration.zero,
                total: Duration(minutes: 5),
                timeLabelPadding: 10,
                timeLabelLocation: TimeLabelLocation.none,
              ),
            ),
          );

          MediaProgressBar mediaProgressBar = tester.firstWidget(find.byType(MediaProgressBar));
          expect(mediaProgressBar, isNotNull);

          final baseSize = tester.getSize(find.byType(MediaProgressBar));
          expect(baseSize.width, equals(800.0));
          expect(baseSize.height, equals(20.0));
        });
  });

  group('drag callbacks', () {
    testWidgets('methods called the right number of times',
            (WidgetTester tester) async {
          int seekCount = 0;
          int dragStartCount = 0;
          int dragUpdateCount = 0;
          int dragEndCount = 0;
          await tester.pumpWidget(
            MediaProgressBar(
              progress: Duration.zero,
              total: const Duration(minutes: 5),
              onSeek: (duration) {
                seekCount++;
              },
              onDragStart: (details) {
                dragStartCount++;
              },
              onDragUpdate: (details) {
                dragUpdateCount++;
              },
              onDragEnd: () {
                dragEndCount++;
              },
            ),
          );

          // drag from the middle of the widget to the far left side
          await tester.drag(find.byType(MediaProgressBar), const Offset(-100, 0));
          expect(seekCount, 1);
          expect(dragStartCount, 1);
          expect(dragUpdateCount, 2);
          expect(dragEndCount, 1);
        });

    testWidgets('callbacks have accurate duration values',
            (WidgetTester tester) async {
          Duration onSeekDuration = const Duration(seconds: 1);
          Duration onDragStartDuration = const Duration(seconds: 1);
          List<Duration> onDragUpdateDurations = [];
          await tester.pumpWidget(
            Center(
              child: SizedBox(
                width: 200,
                child: MediaProgressBar(
                  progress: Duration.zero,
                  total: const Duration(minutes: 5),
                  onSeek: (duration) {
                    onSeekDuration = duration;
                  },
                  onDragStart: (details) {
                    onDragStartDuration = details.timeStamp;
                  },
                  onDragUpdate: (details) {
                    onDragUpdateDurations.add(details.timeStamp);
                  },
                ),
              ),
            ),
          );

          // drag from the middle of the widget to the far left side
          await tester.drag(find.byType(MediaProgressBar), const Offset(-100, 0));
          expect(onSeekDuration, Duration.zero);
          expect(onDragStartDuration, const Duration(minutes: 2, seconds: 30));
          expect(onDragUpdateDurations[0],
              const Duration(minutes: 1, seconds: 59, milliseconds: 231));
          expect(onDragUpdateDurations[1], Duration.zero);
        });

    testWidgets('callbacks have accurate position values for no side labels',
            (WidgetTester tester) async {
          ThumbDragDetails onDragStartDetails = const ThumbDragDetails();
          List<ThumbDragDetails> onDragDetails = [];
          await tester.pumpWidget(
            Center(
              child: SizedBox(
                width: 200,
                child: MediaProgressBar(
                  progress: Duration.zero,
                  total: const Duration(minutes: 5),
                  onDragStart: (details) {
                    onDragStartDetails = details;
                  },
                  onDragUpdate: (details) {
                    onDragDetails.add(details);
                  },
                ),
              ),
            ),
          );

          // drag from the middle of the widget to the far left side
          await tester.drag(find.byType(MediaProgressBar), const Offset(-100, 0));
          expect(onDragStartDetails.globalPosition, const Offset(400.0, 300.0));
          expect(onDragStartDetails.localPosition, const Offset(100.0, 17.0));
          expect(onDragDetails[0].globalPosition, const Offset(380.0, 300.0));
          expect(onDragDetails[0].localPosition, const Offset(80.0, 17.0));
          expect(onDragDetails[1].globalPosition, const Offset(300.0, 300.0));
          expect(onDragDetails[1].localPosition, const Offset(0.0, 17.0));
        });
  });
}
