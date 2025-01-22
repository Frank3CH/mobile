import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Cart {
  List<CartItem> items = [];

  void addItem(Product product, {int quantity = 1}) {
    CartItem? existingItem = items.firstWhere(
          (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      items.add(existingItem);
    }

    existingItem.quantity += quantity;
  }

  void removeItem(Product product) {
    CartItem? existingItem = items.firstWhere(
          (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 1) {
      existingItem.quantity -= 1;
    } else {
      items.remove(existingItem);
    }
  }

  void updateItemQuantity(Product product, int quantity) {
    final existingItem = items.firstWhere(
          (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (quantity <= 0) {
      items.remove(existingItem);
    } else {
      existingItem.quantity = quantity;
      if (!items.contains(existingItem)) {
        items.add(existingItem);
      }
    }
  }

  void clear() {
    items.clear();
  }

  double get totalPrice {
    return items.fold(0, (total, item) => total + item.product.price * item.quantity);
  }
}