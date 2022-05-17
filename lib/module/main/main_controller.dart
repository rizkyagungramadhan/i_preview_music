import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:i_preview_music/api/music/music_track_request.dart';
import 'package:i_preview_music/api/music/music_track_response.dart';
import 'package:i_preview_music/common/app_state.dart';
import 'package:i_preview_music/module/app_controller.dart';
import 'package:i_preview_music/module/repository.dart';
import 'package:i_preview_music/utility/app_error_utility.dart';
import 'package:i_preview_music/utility/app_exception.dart';
import 'package:i_preview_music/utility/extension/string_ext.dart';
import 'package:just_audio/just_audio.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.


class MainController extends GetxController with AppController {
  final _repository = Get.find<Repository>();
  RxList<MusicTrackResponse> results = RxList<MusicTrackResponse>();
  RxBool isConnectionAvailable = true.obs;
  Rx<AppState> appState = AppState.idle.obs;
  Rxn<MusicTrackResponse> selectedMusic = Rxn<MusicTrackResponse>();
  final AudioPlayer audioPlayer = AudioPlayer();

  ///Keyboard utility
  var isKeyboardVisible = false.obs;
  var keyboardVisibilityController = KeyboardVisibilityController();

  @override
  void onInit() {
    attachKeyboardListener(keyboardVisibilityController, isKeyboardVisible);
    super.onInit();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  /// Doc : Search music from iTunes API with given query [artistName].
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 22:59.
  search({required String artistName}) async {
    try {
      ///Prevent this function called repetitively
      if (appState.value == AppState.loading) return;
      appState.value = AppState.loading;

      ///Show search animation when [artistName] query was empty
      if (artistName.isNullOrEmpty) return appState.value = AppState.idle;

      ///Validate connection availability
      await forceToConnected(isConnectionAvailable);

      ///Execute API Call
      return await _repository
          .searchByArtistName(
          request: MusicTrackRequest(artistName: artistName))
          .then((response) {
        ///Validate response
        response.validate();

        ///Assign all response data when valid
        results.assignAll(response.data ?? []);
        appState.value = AppState.completed;
      });
    } catch (error, stacktrace) {
      appState.value = AppState.failed;
      showInformationSnackbar(error);
      if (error is! AppException) AppErrorUtility.printInfo(stacktrace);
    }
  }

  /// Doc : Play a song track. When already success initialized it will play automatically.
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 22:59.
  playTrack(MusicTrackResponse item) async {
    try {
      ///Restart track if user choose the same track
      if ((selectedMusic.value?.trackId ?? 0) == item.trackId) {
        return await audioPlayer.seek(Duration.zero);
      }

      ///Validate stream url availability
      if (item.previewStreamUrl.isNullOrEmpty) {
        throw AppException("Stream url for this track cannot be found");
      }

      ///Reset previous selection (if exist) to null
      if (selectedMusic.value is MusicTrackResponse) _updateSelectedMusic();

      ///Check device internet connection
      final isConnected = await checkConnection();
      if (!isConnected) {
        return showInformationSnackbar("No internet connection");
      }

      ///Prepare & configure audio source
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(item.previewStreamUrl!),
        ),
        initialPosition: Duration.zero,
        preload: true,
      );

      ///Play track & update selection to current track
      audioPlayer.play();
      _updateSelectedMusic(item);
    } on PlayerException catch (error, stacktrace) {
      _onPlayTrackError(error, stacktrace);
    } on PlayerInterruptedException catch (error, stacktrace) {
      _onPlayTrackError(error, stacktrace);
    } catch (error, stacktrace) {
      _onPlayTrackError(error, stacktrace);
    }
  }

  /// Doc : Notify user when something went error when playing song track.
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 23:00.
  _onPlayTrackError(error, stacktrace) {
    audioPlayer.pause();
    results.refresh();
    showInformationSnackbar(error is PlayerException ? error.message : error);
    if (error is! AppException) AppErrorUtility.printInfo(stacktrace);
  }

  /// Doc : Update current selected [MusicTrackResponse].
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 23:00.
  _updateSelectedMusic([MusicTrackResponse? item]) {
    selectedMusic.value = item;
    results.refresh();
  }
}
