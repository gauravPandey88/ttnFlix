import 'package:dio/dio.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/network/ttnflix_dio_service.dart';
import 'package:ttn_flix/network/ttnflix_api_interface.dart';
import 'package:ttn_flix/network/ttnflix_custom_exception.dart';
import 'package:ttn_flix/network/ttnflix_typedef.dart';

/// A service class implementing methods for basic API requests.
class TtnflixApiClient implements TtnflixApiInterface {
  /// An instance of [DioService] for network requests
  ///
  final TtnflixDioService _dioService = SL.get<TtnflixDioService>();


  /// An implementation of the base method for cancelling
  /// requests pre-maturely using the [cancelToken].
  ///
  /// If null, the **default** [cancelToken] inside [DioService] is used.
  @override
  void cancelRequests({CancelToken? cancelToken}) {
    _dioService.cancelRequests(cancelToken: cancelToken);
  }

  @override
  Future<T> getHomeDataApi<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    required T Function(JSON responseBody) converter,
  }) async {
    Object? body;
    try {
      // Entire map of response
      final data = await _dioService.getRequest<JSON?>(
        endpoint,
        queryParams,
        cancelToken,
      );

      // Items of table as json
      body = data.body;
    } on Exception catch (ex) {
      throw TtnflixCustomException.fromDioException(ex);
    }

    try {
      // Returning the deserialized objects
      return converter(body! as JSON);
    } on Exception catch (ex) {
      throw TtnflixCustomException.fromParsingException(ex);
    }
  }
}
