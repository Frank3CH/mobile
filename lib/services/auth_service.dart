import 'package:ESMV_STORE/utils/MLString.dart';
import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthService {
  final Dio _dio = Dio();
  final String apiUrl = '$backUrl/api/login';

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        apiUrl,
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return responseData['token'];
      } else {
        throw Exception('Failed to login with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  Future<bool> isAdmin(String token) async {
    try {
      final response = await _dio.get(
        '$backUrl/api/is_admin',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return responseData['isAdmin'];
      } else {
        throw Exception('Failed to check admin status with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Admin check error: $e');
    }
  }

  bool isTokenExpired(String token) {
    final payload = JwtDecoder.decode(token);
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(payload!['exp'] * 1000);
    return DateTime.now().isAfter(expiryDate);
  }


}
