/// Base exception class for the application.
/// All other exceptions should inherit from this class.
class AppException implements Exception {
  final String? message;
  final dynamic cause;

  AppException({this.message, this.cause});

  @override
  String toString() {
    return 'AppException: $message${cause != null ? '\nCaused by: $cause' : ''}';
  }
}

/// Exception that indicates a network-related error.
/// This could be triggered by network timeouts or connectivity issues.
class NetworkException extends AppException {
  NetworkException({String? message, dynamic cause})
      : super(message: message, cause: cause);

  @override
  String toString() {
    return 'NetworkException: $message${cause != null ? '\nCaused by: $cause' : ''}';
  }
}

/// Exception that indicates a server-related error.
/// This might occur due to issues like 500 Internal Server Error.
class ServerException extends AppException {
  ServerException({String? message, dynamic cause})
      : super(message: message, cause: cause);

  @override
  String toString() {
    return 'ServerException: $message${cause != null ? '\nCaused by: $cause' : ''}';
  }
}

/// Exception that indicates a client-related error.
/// This might be thrown for errors like 400 Bad Request.
class ClientException extends AppException {
  ClientException({String? message, dynamic cause})
      : super(message: message, cause: cause);

  @override
  String toString() {
    return 'ClientException: $message${cause != null ? '\nCaused by: $cause' : ''}';
  }
}

/// Exception for unknown errors that do not fall into the other categories.
class UnknownException extends AppException {
  UnknownException({String? message, dynamic cause})
      : super(message: message, cause: cause);

  @override
  String toString() {
    return 'UnknownException: $message${cause != null ? '\nCaused by: $cause' : ''}';
  }
}

String convertDuration(int seconds) {
  if (seconds >= 86400) {  // 86400 ثانية = يوم واحد
    int days = (seconds / 86400).round();  // تقريب القيمة لأقرب عدد أيام
    return '$days Day${days > 1 ? 's' : ''}';
  } else if (seconds >= 60) {  // 60 ثانية = دقيقة واحدة
    int minutes = (seconds / 60).round();  // تقريب القيمة لأقرب عدد دقائق
    return '$minutes Min${minutes > 1 ? 's' : ''}';
  } else {
    return '$seconds Second';
  }
}