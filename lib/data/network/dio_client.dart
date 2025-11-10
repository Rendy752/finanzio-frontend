import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _baseUrl = 'https://finanzio-api.onrender.com/api/v1';
// const String _baseUrl =
//     'http://127.0.0.1:8000/api/v1';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      contentType: 'application/json',
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 15),
    ),
  );

  dio.interceptors.add(AuthInterceptor(ref));

  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
  return dio;
});

class AuthInterceptor extends Interceptor {
  final Ref ref;
  AuthInterceptor(this.ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  // Tambahkan logika onError untuk menangani 401/403 jika diperlukan (untuk refresh token)
}
