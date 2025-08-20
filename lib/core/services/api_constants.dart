import 'dart:io';

import 'package:dio/dio.dart';

class ApiErrors {
  static const String BAD_REQUEST_ERROR = "Bad Request";
  static const String UNAUTHORIZED_ERROR = "Unauthorized";
  static const String FORBIDDEN_ERROR = "Forbidden";
  static const String NOT_FOUND_ERROR = "Not Found";
  static const String NO_CONTENT = "No Content";
  static const String INTERNAL_SERVER_ERROR = "Internal Server Error";
  static const String NETWORK_ERROR = "Network Error";
  static const String UNKNOWN_ERROR = "Unknown Error";
}

abstract class AppException implements Exception {
  final String message;
  final dynamic cause;

  AppException(this.message, [this.cause]);

  @override
  String toString() => message;
}

class ServerException extends AppException {
  ServerException(String message, [dynamic cause]) : super(message, cause);
}

class NetworkException extends AppException {
  NetworkException(String message, [dynamic cause]) : super(message, cause);
}

class UnknownException extends AppException {
  UnknownException(String message, [dynamic cause]) : super(message, cause);
}

AppException mapErrorToException(dynamic error) {
  if (error is DioException) {
    switch (error.response?.statusCode) {
      case 400:
        return ServerException("${ApiErrors.BAD_REQUEST_ERROR}: ${error.response?.statusCode}", error);
      case 401:
        return ServerException("${ApiErrors.UNAUTHORIZED_ERROR}: ${error.response?.statusCode}", error);
      case 403:
        return ServerException("${ApiErrors.FORBIDDEN_ERROR}: ${error.response?.statusCode}", error);
      case 404:
        return ServerException("${ApiErrors.NOT_FOUND_ERROR}: ${error.response?.statusCode}", error);
      case 422:
        return ServerException("${ApiErrors.NO_CONTENT}: ${error.response?.statusCode}", error);
      case 500:
        return ServerException("${ApiErrors.INTERNAL_SERVER_ERROR}: ${error.response?.statusCode}", error);
      default:
        return UnknownException("${ApiErrors.UNKNOWN_ERROR}: ${error.response?.statusCode}", error);
    }
  } else if (error is IOException) {
    return NetworkException(ApiErrors.NETWORK_ERROR, error);
  } else {
    return UnknownException(ApiErrors.UNKNOWN_ERROR, error);
  }
}

AppException mapCodeToException(int code) {
  switch (code) {
    case 400:
      return ServerException(ApiErrors.BAD_REQUEST_ERROR);
    case 401:
      return ServerException(ApiErrors.UNAUTHORIZED_ERROR);
    case 403:
      return ServerException(ApiErrors.FORBIDDEN_ERROR);
    case 404:
      return ServerException(ApiErrors.NOT_FOUND_ERROR);
    case 422:
      return ServerException(ApiErrors.NO_CONTENT);
    case 500:
      return ServerException(ApiErrors.INTERNAL_SERVER_ERROR);
    default:
      return UnknownException("${ApiErrors.UNKNOWN_ERROR}: $code");
  }
}

String extractErrorCode(dynamic error) {
  if (error is DioException) {
    return "#ER${error.response?.statusCode}";
  }
  return error.cause?.toString() ?? ApiErrors.UNKNOWN_ERROR;
}