import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:i_preview_music/api/music/music_track_response.dart';
import 'package:i_preview_music/module/app_controller.dart';
import 'package:get/get.dart';
import 'package:i_preview_music/utility/app_error_utility.dart';
import 'package:i_preview_music/utility/app_exception.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.


class TrackDetailController extends GetxController with AppController {
  final MusicTrackResponse item;
  TrackDetailController(this.item);

  Rx<Color> artworkColor = Colors.white.obs;

  @override
  void onInit() async {
    await _getArtWorkColor();
    super.onInit();
  }

  /// Doc : Get dominant color of Album Art Work image.
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 23:12.
  _getArtWorkColor() async {
    try {
      final palette = await PaletteGenerator.fromImageProvider(
          CachedNetworkImageProvider(item.trackArtWorkUrl));
      artworkColor.value = palette.dominantColor?.color ?? Colors.white;
    } catch (error) {
      if (kDebugMode) showInformationSnackbar(error.toString());
    }
  }

  /// Doc : Launch an URL & open it in browser.
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 23:11.
  launchUrl(String url) async {
    try {
      if (!await url_launcher.launchUrl(Uri.parse(url))) throw AppException("Could not launch $url");
    } catch (error, stacktrace) {
      showInformationSnackbar(error.toString());
      if (error is! AppException) AppErrorUtility.printInfo(stacktrace);
    }
  }
}
