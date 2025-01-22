import 'package:esmv_store/main.dart';
import 'package:esmv_store/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/components/MLDeliveredDataComponent.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'package:esmv_store/utils/MLString.dart';
import 'package:esmv_store/services/order_service.dart';
import 'package:esmv_store/model/Commande.dart';
import 'package:provider/provider.dart';

class MLCommandeFragment extends StatefulWidget {
  static String tag = '/MLCommandeFragment';

  @override
  MLCommandeFragmentState createState() => MLCommandeFragmentState();
}

class MLCommandeFragmentState extends State<MLCommandeFragment> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Commande> orders = [];
  List<Commande> filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final response = await OrderService().getOrdersByPharmacien();
      if (response.statusCode == 200) {
        setState(() {
          orders = response.data;

          filterOrders();
        });
      } else {
        print('Error fetching orders: ${response.data}');
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  void filterOrders() {
    switch (_tabController.index) {
      case 0:
        filteredOrders = orders;
        break;
      case 1:
        filteredOrders = orders.where((order) => order.status == 'en attente').toList();
        break;
      case 2:
        filteredOrders = orders.where((order) => order.status == 'Validé').toList();
        break;
      case 3:
        filteredOrders = orders.where((order) => order.status == 'terminé').toList();
        break;
      default:
        filteredOrders = orders;
    }
  }

  void _handleTabSelection() {
    setState(() {
      filterOrders();
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Column(
          children: [
            Row(
              children: [
                Text(mlMy_activity!, style: boldTextStyle(size: 20, color: white)).expand(),
                Text(mlHistory!, style: secondaryTextStyle(color: white)).paddingRight(8.0),
              ],
            ).paddingAll(16.0),
            8.width,
            Container(
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: appStore.isDarkModeOn ? black : white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Solde :', style: boldTextStyle(size: 20, color: Colors.black)).paddingLeft(80).expand(),
                      Text(authProvider.userProfile?.solde ?? '0.0', style: secondaryTextStyle(size: 16, color: Colors.black)).paddingRight(80),
                    ],
                  ).paddingAll(8.0),
                  Divider(height: 1, thickness: 0.5),
                  TabBar(
                    controller: _tabController,
                    labelColor: mlColorBlue,
                    indicatorColor: mlColorBlue,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: primaryTextStyle(size: 14),
                    tabs: [
                      Tab(text: mltotal),
                      Tab(text: mlinprogress),
                      Tab(text: mlvalid),
                      Tab(text: mlclosed),
                    ],
                  ),
                  TabBarView(
                    controller: _tabController,
                    children: [
                      MLDeliveredDataComponent(orders: filteredOrders),
                      MLDeliveredDataComponent(orders: filteredOrders),
                      MLDeliveredDataComponent(orders: filteredOrders),
                      MLDeliveredDataComponent(orders: filteredOrders),
                    ],
                  ).expand(),
                ],
              ),
            ).expand()
          ],
        ),
      ),
    );
  }
}
