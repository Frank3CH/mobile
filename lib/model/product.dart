
class Product {
  final int id;
  final String name;
  final String description;
  final String ref;
  final double price;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.ref,
    required this.price,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      ref: json['ref'] as String,
      price: double.parse(json['price']),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ref': ref,
      'price': price,
      'quantity': quantity,
    };
  }
}
