import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/utils/MLString.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  String? _currentFCMToken;

  Future<void> initialize() async {
    await _requestPermissions();
    await _initializeLocalNotifications();
    await _setupFCMToken();
    _setupNotificationHandlers();
  }

  Future<void> _requestPermissions() async {
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    await _localNotifications.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
    );
  }

  Future<void> _setupFCMToken() async {
    _currentFCMToken = await _fcm.getToken();
    if (_currentFCMToken != null) {
      await _sendTokenToServer(_currentFCMToken!);
    }

    _fcm.onTokenRefresh.listen((newToken) {
      _currentFCMToken = newToken;
      _sendTokenToServer(newToken);
    });
  }

  void _setupNotificationHandlers() {
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  }

  Future<void> _sendTokenToServer(String fcmToken) async {
    try {
      final authToken = getStringAsync('token');
      if (authToken.isEmpty) return;

      print('_sendTokenToServer');
      print(fcmToken);

      final dio = Dio();
      final response = await dio.post(
        '$backUrl/api/notification/update-token',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'fcm_token': '$fcmToken',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update FCM token on server');
      }
    } catch (e) {
      print('Error sending FCM token to server: $e');
    }
  }

  Future<void> clearFCMToken() async {
    try {
      final authToken = getStringAsync('token');
      if (authToken.isEmpty) return;

      final dio = Dio();
      await dio.post(
        '$backUrl/api/notification/clear-token',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        ),
      );
    } catch (e) {
      print('Error clearing FCM token: $e');
    }
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    try {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        await _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              importance: Importance.max,
            ),
            iOS: const DarwinNotificationDetails(),
          ),
          payload: message.data.toString(),
        );
      }
    } catch (e) {
      print('Error handling message: $e');
    }
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
      print('Message opened app: ${message.data}');
      navigatorKey.currentState?.pushNamed('/MLDashboardScreen');

  }
}