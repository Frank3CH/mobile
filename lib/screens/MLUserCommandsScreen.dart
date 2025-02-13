import 'package:esmv_store/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:esmv_store/components/MLDeliveredDataComponent.dart';
import 'package:esmv_store/services/order_service.dart';
import 'package:esmv_store/model/Commande.dart';

class MLUserCommandsScreen extends StatefulWidget {
  final String status;

  MLUserCommandsScreen({required this.status});

  @override
  _MLUserCommandsScreenState createState() => _MLUserCommandsScreenState();
}

class _MLUserCommandsScreenState extends State<MLUserCommandsScreen> {
  List<Commande> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final response = await OrderService().getOrdersByPharmacien();
      if (response.statusCode == 200) {
        setState(() {
          print(widget.status);
          orders = response.data.where((order) => order.status == widget.status).toList();
          print(orders);
          isLoading = false;
        });
      } else {
        print('Error fetching orders: ${response.data}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching orders: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)!.order} - ${widget.status}'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : MLDeliveredDataComponent(orders: orders),
    );
  }
}
