import 'package:esmv_store/components/MLCommandsComponent.dart';
import 'package:esmv_store/l10n/gen/app_localizations.dart';
import 'package:esmv_store/main.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'package:esmv_store/utils/MLCommon.dart';
import 'package:esmv_store/providers/order_provider.dart';
import 'package:provider/provider.dart';

class MLOrdersScreen extends StatefulWidget {
  final String orderType;

  MLOrdersScreen({required this.orderType});

  static String tag = '/MLOrdersScreen';

  @override
  MLOrdersScreenState createState() => MLOrdersScreenState();
}

class MLOrdersScreenState extends State<MLOrdersScreen> {
  PageController controller = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    init();
    Future.delayed(Duration.zero, () {
      fetchOrders();
    });
  }

  Future<void> init() async {
    //
  }

  void fetchOrders() {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    if (widget.orderType == 'Commande en attente') {
      orderProvider.fetchPendingOrders();
    } else if (widget.orderType == 'Commande validée') {
      orderProvider.fetchClosedOrders();
    }else if (widget.orderType == 'Commande terminée') {
      orderProvider.fetchValidatedOrders();
    } else if (widget.orderType == 'Commande refusée') {
      orderProvider.fetchRejectedOrders();

    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    print(widget.orderType);
    List<dynamic> orders;
    if (widget.orderType == 'Commande en attente') {
      orders = orderProvider.pendingOrders;
    } else if (widget.orderType == 'Commande validée') {
      orders = orderProvider.closedOrders;
    }else if (widget.orderType == 'Commande terminée') {
      orders = orderProvider.validatedOrders;
    } else if (widget.orderType == 'Commande refusée') {
      orders = orderProvider.rejectedOrders;
    } else {
      orders = [];
    }


    return SafeArea(
      child: Scaffold(
        backgroundColor: appStore.isDarkModeOn ? blackColor : white,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: mlPrimaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          mlBackToPreviousWidget(context, white),
                          8.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.orderType, style: boldTextStyle(size: 14, color: white)),
                            ],
                          ),
                        ],
                      ).paddingAll(16.0),
                    ],
                  ),
                ),
              ),
            ),
            orders.isEmpty
                ? SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text('${AppLocalizations.of(context)!.noorderfound}', style: boldTextStyle(size: 18)),
              ),
            )
                : SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return MLCommandsComponent(orders: orders);
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
