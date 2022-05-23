import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mono_management/resources/constansts.dart';
import 'package:mono_management/src/core/network/token_inteceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'exception_handler.dart';

/// Class that makes API call easier
class DioManager {
  final Dio dio = Dio();

  static final DioManager singleton = DioManager._internal();

  DioManager._internal();

  factory DioManager() => singleton;

  static void configure() {
    singleton.dio.options
      ..baseUrl = baseApiUrl
      ..connectTimeout = apiConnectTimeout
      ..sendTimeout = apiSendTimeout
      ..receiveTimeout = apiReceiveTimeout;

    singleton.dio.interceptors.add(QueuedInterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      ///Example for add headers for every request:
      /// options.headers["TimeZoneOffset"] =
      ///     DateTime.now().timeZoneOffset.inMilliseconds;
      handler.next(options);
    }));
    singleton.dio.interceptors.add(TokenInterceptor(singleton.dio));
    if (!kReleaseMode) {
      singleton.dio.interceptors
          .add(PrettyDioLogger(requestBody: true, requestHeader: true));
    }
  }

  /// Instance of decoder for decoding API results
  static const JsonDecoder _decoder = JsonDecoder();

  Response _normalizeResponse(Response response) {
    Map<String, dynamic> result;
    if (response.data is String) {
      result = _decoder.convert(response.data);
    } else {
      result = response.data;
    }
    response.data = result;
    return response;
  }

  /// DIO GET
  /// take [url], concrete route
  Future<Response> get(String url,
      {Map<String, dynamic>? headers, Map<String, dynamic>? json}) async {
    return dio
        .get(url, queryParameters: json, options: Options(headers: headers))
        .then(_normalizeResponse)
        .catchError((error) {
      handleError(error, _decoder);
    });
  }

  /// DIO POST
  /// take [url], concrete route
  Future<Response> post(String url,
      {Map<String, dynamic>? headers, dynamic body, dynamic encoding}) async {
    return dio
        .post(url, data: body, options: Options(headers: headers))
        .then(_normalizeResponse)
        .catchError((error) {
      handleError(error, _decoder);
    });
  }

  /// DIO PUT
  /// take [url], concrete route
  Future<Response> put(String url,
      {dynamic body, dynamic encoding, Options? options}) async {
    return dio
        .put(url, data: body, options: options)
        .then(_normalizeResponse)
        .catchError((error) {
      handleError(error, _decoder);
    });
  }

  /// DIO DELETE
  /// take [url], concrete route
  Future<Response> delete(String url,
          {Map<String, dynamic>? headers,
          dynamic body,
          dynamic encoding}) async =>
      dio
          .delete(url, data: body, options: Options(headers: headers))
          .then(_normalizeResponse)
          .catchError((error) {
        handleError(error, _decoder);
      });
}
