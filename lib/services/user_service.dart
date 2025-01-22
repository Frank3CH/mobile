import 'package:ESMV_STORE/utils/MLString.dart';
import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/model/MLUserProfile.dart';

class UserService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: backUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  Future<MLUserProfile> fetchUserProfile() async {
    String? token = getStringAsync('token');
    final response = await _dio.get(
      '/api/profile',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      return MLUserProfile.fromJson(response.data);
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
