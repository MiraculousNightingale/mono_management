import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'exception_manager.dart';
import 'package:meta/meta.dart';

@alwaysThrows
void handleError(DioError error, JsonDecoder _decoder) {
  if (error.error is SocketException)
    throw error.error;
  else if (error.type == DioErrorType.receiveTimeout ||
      error.type == DioErrorType.sendTimeout ||
      error.type == DioErrorType.connectTimeout) {
    throw ConnectionTimeoutException();
  } else if (error.response != null &&
      error.response?.statusCode != null &&
      exceptions.containsKey(error.response?.statusCode)) {
    //throw exceptions![error.response!.statusCode](error.response!.data.toString());
  } else {
    throw FetchingDataException();
  }
}
