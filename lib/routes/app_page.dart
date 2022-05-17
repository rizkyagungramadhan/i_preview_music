import 'package:get/get.dart';
import 'package:i_preview_music/module/main/main_page.dart';
import 'package:i_preview_music/module/trackdetail/track_detail_page.dart';
import 'package:i_preview_music/routes/app_route.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.


class AppPage {
  const AppPage._();

  static final routes = [
    GetPage(name: AppRoute.main, page: () => const MainPage()),
    GetPage(name: AppRoute.trackDetail, page: () => const TrackDetailPage()),
  ];
}
