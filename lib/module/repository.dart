import 'package:i_preview_music/api/dio_client.dart';
import 'package:i_preview_music/api/music/music_api.dart';
import 'package:i_preview_music/api/music/music_track_request.dart';
import 'package:i_preview_music/api/music/music_track_response.dart';
import 'package:i_preview_music/api/response_list.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.

class Repository {
  Repository._();

  ///API
  late final MusicApi _musicApi;

  static final Repository _repository = Repository._();

  factory Repository.initialize() {
    ///Configure [Dio] instance inside [DioClient] factory constructor
    final dioClient = DioClient.initialize();

    return _repository.._musicApi = MusicApi(dioClient);
  }

  ///API Calls
  Future<ResponseList<MusicTrackResponse>> searchByArtistName(
          {required MusicTrackRequest request}) async =>
      await _musicApi.search(request);
}
