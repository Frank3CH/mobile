import 'package:esmv_store/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/components/MLProductDetailComponent.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'package:esmv_store/utils/MLCommon.dart';
import 'package:esmv_store/utils/MLImage.dart';
import 'package:provider/provider.dart';
import 'package:esmv_store/providers/product_provider.dart';

class MLProductDetailScreen extends StatefulWidget {
  final int productId;
  MLProductDetailScreen({required this.productId});
  @override
  MLProductDetailScreenState createState() => MLProductDetailScreenState();
}

class MLProductDetailScreenState extends State<MLProductDetailScreen> {
  PageController controller = PageController();
  List<String?> slides = [ml_ic_mediTwo];
  TextEditingController quantityController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProductDetails(widget.productId);
    });
  }

  Future<void> _showQuantityDialog(BuildContext context, dynamic product) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Quantity'),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Ajouter au panier'),
              onPressed: () {
                int quantity = int.tryParse(quantityController.text) ?? 1;
                Provider.of<CartProvider>(context, listen: false)
                    .addToCart(product, quantity: quantity);
                Navigator.pop(context);
                toast('Added to cart successfully');
                finish(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                if (productProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                final product = productProvider.productDetail;

                if (product == null) {
                  return Center(child: Text('Product not found'));
                }

                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: white,
                      automaticallyImplyLeading: false,
                      expandedHeight: 250,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Container(
                              width: double.infinity,
                              height: context.height() * 0.42,
                              color: Colors.grey.shade50,
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  PageView(
                                    controller: controller,
                                    children: slides.map(
                                          (e) {
                                        return commonCachedNetworkImage(
                                          e.validate(),
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ],
                              ),
                            ),
                            mlBackToPreviousWidget(context, black)
                                .paddingOnly(left: 16, top: 16),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          if (index == 0) {
                            return MLProductDetailComponent(
                              productName: product.name,
                              description: product.description,
                              ref: product.ref,
                              price: product.price.toString(),
                              quantity: product.quantity.toString(),
                            );
                          }
                          return null;
                        },
                        childCount: 1,
                      ),
                    ),
                  ],
                );
              },
            ),
            Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                final product = productProvider.productDetail;
                return AppButton(
                  color: mlPrimaryColor,
                  width: context.width(),
                  onTap: product != null
                      ? () => _showQuantityDialog(context, product)
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Ajouter au panier', style: boldTextStyle(color: white)),
                      4.width,
                      Icon(Icons.shopping_bag_outlined, color: white),
                    ],
                  ),
                ).paddingOnly(right: 16.0, left: 16.0, bottom: 8.0);
              },
            ),
          ],
        ),
      ),
    );
  }
}