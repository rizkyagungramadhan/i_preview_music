import 'package:i_preview_music/api/dio_client.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.

class Repository {
  Repository._();

  static final Repository _repository = Repository._();

  factory Repository.initialize() {
    ///Configure [Dio] instance inside [DioClient] factory constructor
    final dioClient = DioClient.initialize();

    return _repository;
  }
}
