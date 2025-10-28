import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// URL Backend FastAPI Anda
const String _baseUrl =
    'http://127.0.0.1:8000/api/v1'; // Android Emulator uses 10.0.2.2
// Jika targetnya Web/Desktop: const String _baseUrl = 'http://localhost:8000/api/v1';

// Provider yang akan digunakan oleh Riverpod untuk mendapatkan instance Dio
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      contentType: 'application/json',
      receiveTimeout: const Duration(seconds: 15),
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    ),
  );

  // Menambahkan Interceptor untuk JWT
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

    // Jika token ada, tambahkan ke header Authorization
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  // Tambahkan logika onError untuk menangani 401/403 jika diperlukan (untuk refresh token)
}
