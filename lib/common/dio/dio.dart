import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mark7/common/const/data.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('[Req]: ${options.method} ${options.uri}');

    if (options.headers['accessToken'] == true) {
      options.headers.remove('accessToken');

      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({
        'Authorization': 'Bearer $accessToken',
      });
    }

    if (options.headers['refreshToken'] == true) {
      options.headers.remove('refreshToken');

      final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({
        'Authorization': 'Bearer $refreshToken',
      });
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('[Res]: ${response.requestOptions.method} ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log('[Err]: ${err.requestOptions.method} ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    if (refreshToken == null) {
      return handler.reject(err);
    }

    // when 401 error occurs, try to refresh token
    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/refresh';

    // If the error is 401 and the request is not for refreshing the token,
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();
      try {
        final resp = await dio.post(
          'http://$ip/auth/refresh',
          options: Options(
            headers: {
              'Authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = resp.data['accessToken'];
        final options = err.requestOptions;

        // Change New Access Token
        options.headers.addAll({
          'Authorization': 'Bearer $accessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // Retry Fetch
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.reject(e);
      }
    }

    super.onError(err, handler);
  }
}
