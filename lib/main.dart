import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_preview_music/module/app.dart';
import 'package:i_preview_music/module/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///TODO : Is app should be forced to portrait? If yes on iOS should add <string>UIInterfaceOrientationPortrait</string> into Info.plist.
  ///written by rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 22:37.

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    ///Create & Inject [Repository]
    final repository = Repository.initialize();
    Get.put(repository);

    runApp(const App());
  });
}
