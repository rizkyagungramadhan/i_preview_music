import 'package:dio/dio.dart';
import 'package:i_preview_music/api/url_setting.dart';
import 'package:i_preview_music/utility/app_error_utility.dart';
import 'package:i_preview_music/utility/extension/response_ext.dart';
import 'package:i_preview_music/utility/response_exception.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.

class DioClient {
  late final Dio _dio;

  DioClient._();

  static final DioClient _dioClient = DioClient._();

  ///Initialize [DioClient] only once (Singleton) for API usage
  factory DioClient.initialize() {
    final dioInstance = Dio(BaseOptions(
        baseUrl: UrlSetting.baseUrl,
        connectTimeout: UrlSetting.maxConnectTimeOut,
        receiveTimeout: UrlSetting.maxReceiveTimeOut,
        sendTimeout: UrlSetting.maxSendTimeOut,
        receiveDataWhenStatusError: true,
        validateStatus: (status) => (status ?? 200) <= 503));
    return _dioClient.._dio = dioInstance;
  }

  /// Doc : Use it for [GET] method.
  /// Use [options] if you want to override [BaseOptions] provided inside [initialize]
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 21:25.
  Future<dynamic> get(String uriPath,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final Response response = await _dio.get(uriPath,
          queryParameters: queryParameters, options: options);
      return response.parse();
    } on DioError catch (e) {
      AppErrorUtility.printInfo(e.message);
      throw ResponseException(AppErrorUtility.handleError(e));
    } catch (e) {
      AppErrorUtility.printInfo(e);
      throw ResponseException(AppErrorUtility.handleError(e));
    }
  }

  /// Doc : Use it for [POST] method.
  /// Use [options] if you want to override [BaseOptions] provided inside [initialize]
  /// @author rizkyagungramadhan@gmail.com on 17-May-2022, Tue, 21:25.
  Future<dynamic> post(String uriPath,
      {data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final Response response = await _dio.post(
        uriPath,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.parse();
    } on DioError catch (e) {
      AppErrorUtility.printInfo(e.message);
      throw ResponseException(AppErrorUtility.handleError(e));
    } catch (e) {
      AppErrorUtility.printInfo(e);
      throw ResponseException(AppErrorUtility.handleError(e));
    }
  }
}
