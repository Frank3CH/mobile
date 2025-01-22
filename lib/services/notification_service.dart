import 'package:ESMV_STORE/model/MLNotificationData.dart';
import 'package:ESMV_STORE/utils/MLString.dart';
import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';


class NotificationService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: backUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  Future<Response> sendNotification(Map<String, dynamic> notificationData) async {
    String? token = getStringAsync('token');
    return await _dio.post('/api/notifications', data: notificationData, options: Options(
      headers: {'Authorization': 'Bearer $token'},
    ));
  }

  Future<Response> getNotifications() async {
    String? token = getStringAsync('token');
    return await _dio.get('/api/notifications', options: Options(
      headers: {'Authorization': 'Bearer $token'},
    ));
  }

  Future<List<MLNotificationData>> fetchNotifications() async {
    String? token = getStringAsync('token');
    final response = await Dio().get(
      '$backUrl/api/notifications',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((notification) => MLNotificationData.fromJson(notification))
          .toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

}
