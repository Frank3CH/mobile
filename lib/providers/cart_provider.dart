import 'package:ESMV_STORE/model/cart.dart';
import 'package:ESMV_STORE/model/product.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Cart _cart = Cart();

  Cart get cart => _cart;

  void addToCart(Product product, {int quantity = 1}) {
    _cart.addItem(product, quantity: quantity);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.removeItem(product);
    notifyListeners();
  }

  void clearCart() {
    _cart = Cart();
    notifyListeners();
  }

  double get totalPrice {
    return _cart.totalPrice;
  }

  void updateItemQuantity(Product product, int quantity) {
    _cart.updateItemQuantity(product, quantity);
    notifyListeners();
  }
}