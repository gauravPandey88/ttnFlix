// ignore_for_file: constant_identifier_names
import 'package:dio/dio.dart';

/// An enum that holds names for our custom exceptions.
enum ExceptionType {
  /// The exception for a prematurely cancelled request.
  CancelException,

  /// The exception for a failed connection attempt.
  ConnectTimeoutException,

  /// The exception for failing to send a request.
  SendTimeoutException,

  /// The exception for failing to receive a response.
  ReceiveTimeoutException,

  /// The exception for no internet connectivity.
  SocketException,

  /// A better name for the socket exception.
  FetchDataException,

  /// The exception for an incorrect parameter in a request/response.
  FormatException,

  /// The exception for an unknown type of failure.
  UnrecognizedException,

  /// The exception for an unknown exception from the api.
  ApiException,

  /// The exception for any parsing failure encountered during
  /// serialization/deserialization of a request.
  SerializationException,
  UnKnownException
}

class TtnflixCustomException implements Exception {
  final String name, message;
  final String? code;
  final int? statusCode;
  final ExceptionType exceptionType;

  TtnflixCustomException({
    this.code,
    int? statusCode,
    required this.message,
    this.exceptionType = ExceptionType.ApiException,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory TtnflixCustomException.fromDioException(Exception error) {
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            return TtnflixCustomException(
              exceptionType: ExceptionType.CancelException,
              statusCode: error.response?.statusCode,
              message: 'Request cancelled prematurely',
            );
          case DioExceptionType.connectionTimeout:
            return TtnflixCustomException(
              exceptionType: ExceptionType.ConnectTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Connection not established',
            );
          case DioExceptionType.sendTimeout:
            return TtnflixCustomException(
              exceptionType: ExceptionType.SendTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to send',
            );
          case DioExceptionType.receiveTimeout:
            return TtnflixCustomException(
              exceptionType: ExceptionType.ReceiveTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to receive',
            );
          case DioExceptionType.badCertificate:
            return TtnflixCustomException(
              exceptionType: ExceptionType.ReceiveTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to receive',
            );
          case DioExceptionType.badResponse:
            return TtnflixCustomException(
              exceptionType: ExceptionType.ReceiveTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to receive',
            );

          case DioExceptionType.connectionError:
            return TtnflixCustomException(
              exceptionType: ExceptionType.ConnectTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to receive',
            );

          case DioExceptionType.unknown:
            return TtnflixCustomException(
              exceptionType: ExceptionType.UnKnownException,
              statusCode: error.response?.statusCode,
              message: 'Failed to receive',
            );
        }
      } else {
        return TtnflixCustomException(
          exceptionType: ExceptionType.UnrecognizedException,
          message: 'Error unrecognized',
        );
      }
    } on FormatException catch (e) {
      return TtnflixCustomException(
        exceptionType: ExceptionType.FormatException,
        message: e.message,
      );
    } on Exception catch (_) {
      return TtnflixCustomException(
        exceptionType: ExceptionType.UnrecognizedException,
        message: 'Error unrecognized',
      );
    }
  }

  factory TtnflixCustomException.fromParsingException(Exception error) {
    return TtnflixCustomException(
      exceptionType: ExceptionType.SerializationException,
      message: 'Failed to parse network response to model or vice versa',
    );
  }
}
