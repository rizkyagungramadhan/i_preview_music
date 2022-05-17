import 'package:i_preview_music/utility/app_exception.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.


class ResponseException implements AppException {

  @override
  String message;

  ResponseException(this.message);

  @override
  String toString() => message;
}