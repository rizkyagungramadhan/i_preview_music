import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_preview_music/style/app_color.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.

class AppTheme {
  const AppTheme._();

  static final ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: AppColor.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColor.primary,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light)),
    primaryColor: AppColor.primary,
    backgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: AppColor.accent, primary: AppColor.primary),
  );
}
