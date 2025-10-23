import 'package:dio/dio.dart';
import 'package:finanzio/data/network/dio_client.dart';
import 'package:finanzio/domain/models/auth_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Repository Provider
final authRepositoryProvider = Provider(
  (ref) => AuthRepository(ref.read(dioProvider)),
);

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<TokenResponse> login(String email, String password) async {
    try {
      final dataToSend = {'username': email, 'password': password};

      final response = await _dio.post(
        '/token',
        data: dataToSend,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      final token = TokenResponse.fromJson(response.data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token.accessToken);

      return token;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        throw Exception(
          e.response?.data['detail'] ?? 'Kredensial tidak valid.',
        );
      }
      throw Exception(e.message ?? 'Login failed due to network error.');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token')?.isNotEmpty ?? false;
  }
}
