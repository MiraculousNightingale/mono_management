import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mono_management/src/core/network/token_inteceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'exception_handler.dart';

/// Timeout of API call
final Duration timeout = Duration(seconds: 20);

/// Class that makes API call easier
class DioManager {
  ///Do not change
  static String baseUrl = "https://api.monobank.ua/";
  Dio dio = Dio();

  static final DioManager singleton = DioManager._internal();

  DioManager._internal();

  factory DioManager() => singleton;

  static void configure() {
    singleton.dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = timeout.inMilliseconds
      ..sendTimeout = 20000
      ..receiveTimeout = 60000;

    singleton.dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      singleton.dio.interceptors.requestLock.lock();
      options.headers["TimeZoneOffset"] =
          DateTime.now().timeZoneOffset.inMilliseconds;
      singleton.dio.interceptors.requestLock.unlock();
      handler.next(options);
    }));
    if (!kReleaseMode)
      singleton.dio.interceptors
          .add(PrettyDioLogger(requestBody: true, requestHeader: true));

    singleton.dio..interceptors.add(TokenInterceptor(singleton.dio));

  }

  /// Instance of decoder for decoding API results
  final JsonDecoder _decoder = JsonDecoder();

  Response _normalizeResponse(Response response) {
    Map<String, dynamic> result;
    if (response.data is String)
      result = _decoder.convert(response.data);
    else
      result = response.data;
    response.data = result;
    return response;
  }

  /// DIO GET
  /// take [url], concrete route
  Future<Response> get(String url,
          {Map<String, dynamic>? headers, Map<String, dynamic>? json}) async =>
      await dio
          .get(url, queryParameters: json, options: Options(headers: headers))
          .then(_normalizeResponse)
          .catchError((error) {
        handleError(error, _decoder);
      });

  /// DIO POST
  /// take [url], concrete route
  Future<Response> post(String url,
          {Map<String, dynamic>? headers, body, encoding}) async =>
      await dio
          .post(url, data: body, options: Options(headers: headers))
          .then(_normalizeResponse)
          .catchError((error) {
        handleError(error, _decoder);
      });

  /// DIO PUT
  /// take [url], concrete route
  Future<Response> put(String url, {body, encoding, Options? options}) async {
    return await dio
        .put(url, data: body, options: options)
        .then(_normalizeResponse)
        .catchError((error) {
      handleError(error, _decoder);
    });
  }

  /// DIO DELETE
  /// take [url], concrete route
  Future<Response> delete(String url,
          {Map<String, dynamic>? headers, body, encoding}) async =>
      await dio
          .delete(url, data: body, options: Options(headers: headers))
          .then(_normalizeResponse)
          .catchError((error) {
        handleError(error, _decoder);
      });
}
