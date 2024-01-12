import 'package:dio/dio.dart';
import 'package:ttn_flix/network/ttnflix_typedef.dart';

abstract class TtnflixApiInterface{
  const TtnflixApiInterface();

  ///
  /// If null, the **default** [cancelToken] inside [DioService] is used.
  void cancelRequests({CancelToken? cancelToken});

  Future<T> getHomeDataApi<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    required T Function(JSON responseBody) converter,
  });
}