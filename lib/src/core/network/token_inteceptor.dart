
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TokenInterceptor extends InterceptorsWrapper {
 Dio? previous;
 Dio refreshDio = Dio();

 TokenInterceptor(previous) {
   this.previous = previous;
 }

 @override
 onRequest(RequestOptions options, RequestInterceptorHandler requestInterceptorHandler) async {
   String accessToken = 'ubUgYeqVFDEHoKNpCtq_jSxTMVGAt22DSPIO6jSV9N2w'; //TODO: Hueta, token ebat ahahahah

   if (!kReleaseMode) print(accessToken);

   options.headers["X-Token"] = accessToken;
   return requestInterceptorHandler.next(options);
 }

}
