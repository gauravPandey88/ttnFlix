

import 'package:ttn_flix/network/ttnflix_typedef.dart';

class ResponseModel<T> {
  final ResponseHeadersModel? headers;
  final T body;
  final String? message;
  final int? code;

  const ResponseModel({
    this.headers,
    required this.body,
    required this.code,
    this.message
  });

  factory ResponseModel.fromJson(JSON? json) {
    return ResponseModel(
      body: json?['data'] as T,
      message: json?['message'] as String?,
      code: json?['code'] as int,
    );
  }
}

class ResponseHeadersModel {
  final String message;
  final int? code;

  const ResponseHeadersModel({
    required this.message,
    this.code,
  });

  factory ResponseHeadersModel.fromJson(JSON json) {
    return ResponseHeadersModel(
      message: json['message'] as String,
      code: json['code'] as int?,
    );
  }
}