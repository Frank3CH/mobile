import 'package:esmv_store/utils/MLImage.dart';

class MLNotificationData {
  String image;
  String title;
  String time;
  String status;
  String? detail;

  MLNotificationData({
    required this.image,
    required this.title,
    required this.time,
    required this.status,
     this.detail,
  });

  factory MLNotificationData.fromJson(Map<String, dynamic> json) {
    return MLNotificationData(
      image: ml_ic_mediThree!,
      title: json['message'],
      time: json['dateEnvoi'],
      status: json['status'],

    );
  }
}
