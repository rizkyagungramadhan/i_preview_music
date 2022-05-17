import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_preview_music/api/music/music_track_response.dart';
import 'package:i_preview_music/common/app_state.dart';
import 'package:i_preview_music/common/placeholder_type.dart';
import 'package:i_preview_music/module/main/main_controller.dart';
import 'package:i_preview_music/module/main/music_item_view.dart';
import 'package:i_preview_music/module/main/music_player_view.dart';
import 'package:i_preview_music/style/app_color.dart';
import 'package:i_preview_music/style/app_dimen.dart';
import 'package:i_preview_music/utility/extension/widget_ext.dart';
import 'package:i_preview_music/widget/app_screen.dart';
import 'package:i_preview_music/widget/placeholder_widget.dart';
import 'package:i_preview_music/widget/search_text_field.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final _controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    final searchTextController = TextEditingController();
    DateTime backPressedDateTime = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        ///Prevent user from accidentally exit the App from back button
        final isBackPressedTwice =
            DateTime.now().difference(backPressedDateTime) >=
                const Duration(seconds: 2);
        backPressedDateTime = DateTime.now();
        if (isBackPressedTwice) {
          _controller.showToast("Press once more to exit");
          return false;
        }
        return true;
      },
      child: AppScreen(
          isUsingKeyboard: true,
          body: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SearchTextField(
                    key: const Key("searchTextField"),
                    textEditingController: searchTextController,
                    placeholder: "Search by artist name",
                    onSearch: (artistName) =>
                        _controller.search(artistName: artistName),
                  ),

                  ///Observable Widgets
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async => await _controller.search(
                          artistName: searchTextController.text),
                      child: Obx(() => (() {
                            ///Manage state

                            if (!_controller.isConnectionAvailable.value) {
                              ///Return when no internet connection
                              return const PlaceholderWidget(
                                      type: PlaceholderType.noConnection)
                                  .asScrollable();
                            }

                            switch (_controller.appState.value) {
                              case AppState.idle:

                                ///Return basic instruction when app first time start
                                return const PlaceholderWidget(
                                    type: PlaceholderType.typeASearch);
                              case AppState.loading:

                                ///Return existing list to prevent multiple CircularProgressIndicator in same screen
                                if (_controller.results.isNotEmpty) {
                                  return _buildMusicList();
                                }

                                ///CircularProgressIndicator in the center of the screen
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.primary,
                                  ),
                                );
                              case AppState.failed:

                                ///Return failed animation
                                return const PlaceholderWidget(
                                        type:
                                            PlaceholderType.somethingWentWrong)
                                    .asScrollable();
                              case AppState.completed:

                                ///Return a list when state was completed
                                return _buildMusicList();
                              default:
                                return const SizedBox.shrink();
                            }
                          }())),
                    ),
                  ),
                ],
              ),

              ///Music Player
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Obx(() {
                    final selectedMusic = _controller.selectedMusic.value;
                    return Visibility(
                      visible: !_controller.isKeyboardVisible.value,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              scale: animation, child: child);
                        },
                        child: selectedMusic is MusicTrackResponse
                            ? MusicPlayerView(
                                audioPlayer: _controller.audioPlayer,
                                item: selectedMusic,
                                onStopOrPause: _controller.results.refresh,
                                onPlay: _controller.results.refresh,
                              )
                            : const SizedBox.shrink(),
                      ),
                    );
                  }))
            ],
          )),
    );
  }

  Widget _buildMusicList() {
    return Column(
      children: [
        ///Build Music List Item View if not empty
        Expanded(
          child: _controller.results.isEmpty
              ? const PlaceholderWidget(type: PlaceholderType.noData)
              : ListView.builder(
                  padding: _controller.selectedMusic.value is MusicTrackResponse
                      ? const EdgeInsets.only(
                          bottom: AppDimen.musicPlayerHeight)
                      : EdgeInsets.zero,
                  itemCount: _controller.results.length,
                  itemBuilder: (_, position) {
                    final MusicTrackResponse item =
                        _controller.results[position];
                    final isPlaying =
                        (_controller.selectedMusic.value?.trackId ?? 0) ==
                            item.trackId;

                    return MusicItemView(
                      item: item,
                      onPressed: () async => await _controller.playTrack(item),
                      isPlaying: isPlaying && _controller.audioPlayer.playing,
                    );
                  }),
        ),
      ],
    );
  }
}
