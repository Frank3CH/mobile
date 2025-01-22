class History {
  final int id;
  final int userId;
  final int orderId;
  final DateTime dateConsultation;

  History({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.dateConsultation,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      userId: json['user_id'],
      orderId: json['order_id'],
      dateConsultation: DateTime.parse(json['date_consultation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'order_id': orderId,
      'date_consultation': dateConsultation.toIso8601String(),
    };
  }
}
