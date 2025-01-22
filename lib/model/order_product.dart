class OrderProduct {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;

  OrderProduct({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
    };
  }
}
