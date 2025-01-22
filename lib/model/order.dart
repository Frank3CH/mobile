// lib/models/order.dart
class Order {
  final int id;
  final int pharmacienId;
  final int fournisseurId;
  final String status;
  final DateTime dateCreation;
  final DateTime? dateModification;


  Order({
    required this.id,
    required this.pharmacienId,
    required this.fournisseurId,
    required this.status,
    required this.dateCreation,
    this.dateModification,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      pharmacienId: json['pharmacien_id'],
      fournisseurId: json['fournisseur_id'],
      status: json['status'],
      dateCreation: DateTime.parse(json['date_creation']),
      dateModification: json['date_modification'] != null ? DateTime.parse(json['date_modification']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pharmacien_id': pharmacienId,
      'fournisseur_id': fournisseurId,
      'status': status,
      'date_creation': dateCreation.toIso8601String(),
      'date_modification': dateModification?.toIso8601String(),
    };
  }
}


