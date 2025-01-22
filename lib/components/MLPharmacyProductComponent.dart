import 'package:ESMV_STORE/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';
import 'package:ESMV_STORE/screens/MLProductDetailScreen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ESMV_STORE/providers/product_provider.dart';

class MLPharmacyProductComponent extends StatefulWidget {
  static String tag = '/MLPharmacyProductComponent';
  final int? categoryId;

  MLPharmacyProductComponent({this.categoryId}) {
    print('MLPharmacyProductComponent created with categoryId: $categoryId');
  }

  @override
  MLPharmacyProductComponentState createState() => MLPharmacyProductComponentState();
}

class MLPharmacyProductComponentState extends State<MLPharmacyProductComponent> {
  static const _pageSize = 20;
  final PagingController<int, Product> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchProducts(pageKey);
    });
  }

  Future<void> _fetchProducts(int pageKey) async {
    try {
      final productProvider = Provider.of<ProductProvider>(context, listen: false);
      final newProducts = await productProvider.fetchProducts(
        page: pageKey,
        categoryId: widget.categoryId,
      );

      final isLastPage = newProducts.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newProducts);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newProducts, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight,
      child: PagedListView<int, Product>(
        pagingController: _pagingController,
        padding: EdgeInsets.symmetric(horizontal: 16),
        builderDelegate: PagedChildBuilderDelegate<Product>(
          itemBuilder: (context, product, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 5),  // Add bottom margin to create spacing
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radius(12),
                border: Border.all(color: mlColorLightGrey),
                backgroundColor: context.cardColor,
              ),
              child: ListTile(
                title: Text(product.name, style: boldTextStyle(size: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ref ${product.ref}', style: secondaryTextStyle(size: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text('${product.price} MRU', style: boldTextStyle(size: 14, color: mlColorBlue)),
                  ],
                ),
                onTap: () {
                  MLProductDetailScreen(productId: product.id).launch(context);
                },
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (context) => Center(child: CircularProgressIndicator()),
          newPageProgressIndicatorBuilder: (context) => Center(child: CircularProgressIndicator()),
          noItemsFoundIndicatorBuilder: (context) => Center(child: Text('No products found')),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
