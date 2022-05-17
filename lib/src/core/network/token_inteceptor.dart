import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mono_management/resources/constansts.dart';

class TokenInterceptor extends InterceptorsWrapper {
  Dio? previous;

  TokenInterceptor(previous) {
    this.previous = previous;
  }

  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler requestInterceptorHandler) {
    debugPrint('Request token: $accessToken');

    ///Todo: read access token from SecurePreferences
    options.headers["X-Token"] = accessToken;
    return requestInterceptorHandler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    // TODO: Catch 401 error
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
