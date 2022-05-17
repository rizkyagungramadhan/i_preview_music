import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:i_preview_music/module/main/main_page.dart';
import 'package:i_preview_music/module/main/music_player_view.dart';
import 'package:i_preview_music/module/repository.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.


void main() {
  late MainPage page;

  ///Inject [Repository] which needed in [MainController]
  setUp(() {
    Get.delete<Repository>();
    Get.put(Repository.initialize());
    page = MainPage();
  });

  group("Screen behavior", () {
    testWidgets("KeyboardDismissOnTap successfully attached",
            (WidgetTester tester) async {
          ///Pump [MainPage]
          await tester.pumpWidget(MaterialApp(home: page));

          ///Expect [MusicPlayer] is not showing when keyboard show up
          expect(find.byType(KeyboardDismissOnTap), findsOneWidget);
        });

    testWidgets("Hide music player when keyboard show up",
            (WidgetTester tester) async {
          ///Pump [MainPage]
          await tester.pumpWidget(MaterialApp(home: page));

          ///Type a text into SearchTextField
          await tester.enterText(
              find.byKey(const Key("searchTextField")), "asking alexandria");
          await tester.pump();

          ///Expect [MusicPlayer] is not showing when keyboard show up
          expect(find.byType(MusicPlayerView), findsNothing);
        });
  });
}
