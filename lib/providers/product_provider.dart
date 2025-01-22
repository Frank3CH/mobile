import 'package:flutter/material.dart';
import 'package:ESMV_STORE/services/product_service.dart';
import 'package:ESMV_STORE/model/product.dart';
import 'package:ESMV_STORE/model/category.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  List<Product> _products = [];
  List<Category> _categories = [];
  Product? _productDetail;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  List<Product> get products => _products;
  List<Category> get categories => _categories;
  Product? get productDetail => _productDetail;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await _productService.fetchCategories();
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Product>> fetchProducts({int page = 1, bool refresh = false, int? categoryId}) async {
    if (_isLoading) return [];
    _isLoading = true;
    notifyListeners();

    print('Fetching products, page: $page, refresh: $refresh, categoryId: $categoryId');

    try {
      List<Product> newProducts = await _productService.fetchProducts(page: page, categoryId: categoryId);
      print('Products fetched : ${newProducts.length}');

      if (refresh) {
        _products = newProducts;
      } else {
        _products.addAll(newProducts);
      }

      _hasMore = newProducts.length == 20; // Check if there are more products
      _page = page;
      notifyListeners();

      return newProducts;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  void loadMore() {
    if (_hasMore && !_isLoading) {
      print('Loading more products...');
      fetchProducts(page: _page + 1);
    } else {
      print('No more products to load or still loading...');
    }
  }

  Future<void> fetchProductDetails(int productId) async {
    _isLoading = true;
    notifyListeners();
    print('Fetching product details for ID: $productId');

    try {
      _productDetail = await _productService.fetchProductDetails(productId);
    } catch (e) {
      print('Error fetching product details: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchProducts(String query) async {
    _isLoading = true;
    notifyListeners();
    print('Searching products for query: $query');

    try {
      _products = await _productService.searchProducts(query);
    } catch (e) {
      print('Error searching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
