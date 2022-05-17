import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_preview_music/routes/app_page.dart';
import 'package:i_preview_music/routes/app_route.dart';
import 'package:i_preview_music/style/app_theme.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      theme: AppTheme.theme,
      initialRoute: AppRoute.main,
      locale: Get.deviceLocale,
      getPages: AppPage.routes,
      defaultTransition: Transition.rightToLeft,
    );
  }
}
