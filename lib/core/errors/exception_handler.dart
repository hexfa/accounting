import 'package:dio/dio.dart';
import 'package:accounting/core/errors/failures.dart';

class ExceptionHandler {
  static Failure handle(dynamic e) {
    if (e is DioException) {
      return _handleDioException(e);
    }
    return _handleGeneralException(e);
  }

  static Failure _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkFailure(
          "⏳ Request timed out. Please check your internet connection.");
    } else if (e.type == DioExceptionType.cancel) {
      return ServerFailure("❌ Request was canceled.");
    } else if (e.type == DioExceptionType.badResponse) {
      final int statusCode = e.response?.statusCode ?? 500;
      final String message = e.response?.statusMessage ?? "Unknown error";

      switch (statusCode) {
        case 400:
          return BadRequestFailure("🚫 Bad request! Please check your input.");
        case 401:
          return UnAuthorizedFailure("🔑 Unauthorized! Please log in again.");
        case 403:
          return ForbiddenFailure(
              "⛔ Forbidden! You do not have permission for this action.");
        case 404:
          return NotFoundFailure("🔎 Not found! Please try again.");
        case 500:
          return ServerFailure(
              "💥 Internal server error! Please try again later.");
        default:
          return ServerFailure("❗ Server error (Code: $statusCode) - $message");
      }
    } else if (e.type == DioExceptionType.unknown) {
      return ServerFailure("❗ Unknown error: ${e.error}");
    }
    return ServerFailure("⚠️ An unexpected network error occurred.");
  }

  static Failure _handleGeneralException(dynamic e) {
    if (e is FormatException) {
      return BadRequestFailure(
          "📄 Data format error! Please check the response format.");
    } else if (e is TypeError) {
      return UnknownFailure("🛑 Type mismatch error! Please contact support.");
    } else if (e is ArgumentError) {
      return BadRequestFailure("⚠️ Invalid argument provided.");
    }
    return UnknownFailure("⚠️ Unexpected error: ${e.toString()}");
  }
}
