import 'package:dio/dio.dart';
import 'package:finanzio/data/network/dio_client.dart';
import 'package:finanzio/domain/models/auth_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(ref.read(dioProvider)),
);

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<TokenResponse> login(String email, String password) async {
    try {
      // Dio akan mencoba mengkodekan Map ini menjadi string form-urlencoded
      // karena opsi contentType diatur di bawah.
      final dataToSend = {'username': email, 'password': password};

      final response = await _dio.post(
        '/token',
        data: dataToSend, // Kirim Map<String, dynamic>
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      final token = TokenResponse.fromJson(response.data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token.accessToken);

      return token;
    } on DioException catch (e) {
      // Menangani error dari FastAPI (misalnya 400 Bad Request / Invalid credentials)
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        throw Exception(
          e.response?.data['detail'] ?? 'Kredensial tidak valid.',
        );
      }
      // Menangani error jaringan lainnya
      throw Exception(e.message ?? 'Login failed due to network error.');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  // Method untuk mengecek status login
  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token')?.isNotEmpty ?? false;
  }
}
