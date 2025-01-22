import 'package:ESMV_STORE/model/product.dart';

class Commande {
  int id;
  String status;
  String dateCreation;
  String ref;
  double totalPrice;
  final String paymentStatus;
  List<Product> products;

  Commande({required this.id, required this.status, required this.dateCreation, required this.totalPrice, required this.products,required this.paymentStatus,required this.ref});

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['id'],
      status: json['status'],
      dateCreation: json['date_creation'],
      ref: json['ref'],
      totalPrice: double.parse(json['totalprice']),
      paymentStatus: json['payment_status'],
      products: (json['produits'] as List).map((i) => Product.fromJson(i)).toList(),
    );
  }
}

