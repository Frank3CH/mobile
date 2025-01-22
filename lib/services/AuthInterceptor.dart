import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


class AuthInterceptor extends Interceptor {
  final BuildContext context;

  AuthInterceptor(this.context);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = getStringAsync('token');

    if (token == '') {
      Navigator.pushNamedAndRemoveUntil(context, '/MLLoginScreen', (route) => false);
    } else {
      // Token is available, add it to the request
      options.headers['Authorization'] = 'Bearer $token';
      return handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      Navigator.pushNamedAndRemoveUntil(context, '/MLLoginScreen', (route) => false);
    }
    return handler.next(err);
  }
}
