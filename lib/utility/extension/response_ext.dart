import 'dart:convert';

import 'package:dio/dio.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.


extension ResponseExt on Response {
  dynamic parse() {
    if (data is String) return jsonDecode(data);
    return data;
  }
}