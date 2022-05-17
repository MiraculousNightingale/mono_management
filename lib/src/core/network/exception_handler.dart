import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:mono_management/src/core/network/exception_manager.dart';

@alwaysThrows
void handleError(DioError error, JsonDecoder _decoder) {
  if (error.error is SocketException) {
    throw error.error;
  } else if (error.type == DioErrorType.receiveTimeout ||
      error.type == DioErrorType.sendTimeout ||
      error.type == DioErrorType.connectTimeout) {
    throw TimeoutException(error.type.toString());
  } else if (error.response != null &&
      error.response?.statusCode != null &&
      exceptions.containsKey(error.response?.statusCode)) {
    if (error.response?.statusCode == 409) {
      throw ConflictException(error.response?.data);
    }
    throw exceptions[error.response?.statusCode](
        error.response?.data.toString());
  } else {
    throw FetchingDataException();
  }
}
