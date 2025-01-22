import 'package:esmv_store/model/Commande.dart';
import 'package:esmv_store/model/Facture.dart';
import 'package:flutter/material.dart';
import 'package:esmv_store/services/order_service.dart';

class OrderProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();
  List<dynamic> _pendingOrders = [];
  List<dynamic> _rejectedOrders = [];
  List<dynamic> _validatedOrders = [];
  List<dynamic> _closedOrders = [];
  List<Commande> _userOrders = [];
  Map<String, dynamic>? _orderDetails;
  bool _isLoading = false;
  List<Facture> _factures = [];


  List<Facture> get factures => _factures;

  List<dynamic> get pendingOrders => _pendingOrders;
  List<dynamic> get rejectedOrders => _rejectedOrders;
  List<dynamic> get closedOrders => _closedOrders;
  List<dynamic> get validatedOrders => _validatedOrders;
  bool get isLoading => _isLoading;
  Map<String, dynamic>? get orderDetails => _orderDetails;
  List<Commande> get userOrders => _userOrders;

  Future<void> fetchOrderDetails(int orderId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _orderService.getOrderDetails(orderId);
      if (response.statusCode == 200) {
        _orderDetails = response.data;
      } else {
        _orderDetails = null;
      }
    } catch (e) {
      _orderDetails = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, dynamic> getOrderById(int orderId) {
    return _pendingOrders.firstWhere((order) => order['id'] == orderId, orElse: () => null) ??
        _rejectedOrders.firstWhere((order) => order['id'] == orderId, orElse: () => null) ??
        _closedOrders.firstWhere((order) => order['id'] == orderId, orElse: () => null);
  }

  Future<void> validateOrder(int orderId) async {
    try {
      await _orderService.validateOrder(orderId);
      await fetchPendingOrders();
    } catch (e) {}
  }

  Future<void> validateOrderWithQuantities(int orderId, List<Map<String, dynamic>> productUpdates) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _orderService.validateOrderWithQuantities(orderId, productUpdates);
      await fetchPendingOrders(); // Rafraîchir la liste des commandes en attente
      await fetchValidatedOrders(); // Rafraîchir la liste des commandes validées
    } catch (e) {
      print('Error validating order with quantities: $e');
      // Vous pouvez gérer l'erreur ici (par exemple, afficher un message à l'utilisateur)
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> rejectOrder(int orderId) async {
    try {
      await _orderService.rejectOrder(orderId);
      await fetchPendingOrders();
    } catch (e) {}
  }

  Future<void> updateOrderQuantity(int orderId, int productId, int quantity) async {
    try {
      await _orderService.updateOrderQuantity(orderId, productId, quantity);
      await fetchOrderDetails(orderId);
    } catch (e) {}
  }

  Future<void> fetchPendingOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _pendingOrders = await _orderService.fetchPendingOrders();
    } catch (e) {
      _pendingOrders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRejectedOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _rejectedOrders = await _orderService.fetchRejectedOrders();
    } catch (e) {
      _rejectedOrders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchClosedOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _closedOrders = await _orderService.fetchClosedOrders();
    } catch (e) {
      _closedOrders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchValidatedOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _validatedOrders = await _orderService.fetchValidatedOrders();
      print(_validatedOrders);
    } catch (e) {
      _validatedOrders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _orderService.getUserOrders();

      if (response.statusCode == 200) {

        _userOrders = (response.data as List).map((order) => Commande.fromJson(order)).toList();

      } else {
        _userOrders = [];
      }
    } catch (e) {
      _userOrders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  double get accountingBalance {
    double balance = -_userOrders
        .where((order) => order.paymentStatus == 'unpaid')
        .fold(0.0, (sum, order) => sum + order.totalPrice);
    return double.parse(balance.toStringAsFixed(2));
  }

  Future<void> loadFactures() async {
    _isLoading = true;
    notifyListeners();

    try {
      _factures = await _orderService.fetchFactures();
    } catch (error) {
      print('Error loading factures: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
