import 'package:equatable/equatable.dart';
import 'package:i_preview_music/utility/app_exception.dart';
import 'package:i_preview_music/utility/extension/string_ext.dart';
import 'package:i_preview_music/utility/response_exception.dart';
import 'package:json_annotation/json_annotation.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.
part 'response_list.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseList<T> extends Equatable {
  @JsonKey(name: "resultCount")
  final int? total;
  @JsonKey(name: "results")
  final List<T>? data;
  final String? status;
  @JsonKey(name: "errorMessage")
  final String? message;

  const ResponseList(
      {this.total = 0, required this.data, this.status, this.message});

  /// Doc : [response] should be [Map<String, dynamic>] for cast to be successful.
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 22:43.
  factory ResponseList.fromJson(
      dynamic response, T Function(Object? json) fromJsonT) {
    if (response is! Map<String, dynamic>) throw AppException("Response should be in Map types");
    return _$ResponseListFromJson(response, fromJsonT);
  }

  /// Doc : Validate Response. Will throw [ResponseException] with [errorMessage] inside it when failed.
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 22:43.
  void validate() {
    if ((data ?? []).isNotEmpty && errorMessage.isNotNullOrEmpty) return;
    throw ResponseException(errorMessage);
  }

  String get errorMessage =>
      (data is String ? data as String : message) ??
      (status is int
          ? "Oops something went wrong with error code : $status"
          : "Unknown error");

  @override
  List<Object?> get props => [total, data, status, message];
}
