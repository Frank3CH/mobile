import 'package:ESMV_STORE/model/category.dart';
import 'package:dio/dio.dart';
import 'package:ESMV_STORE/model/product.dart';
import 'package:ESMV_STORE/utils/MLString.dart';

class ProductService {
  final Dio _dio = Dio();
  final String apiUrl = '$backUrl/api';

  Future<List<Product>> fetchProducts({int page = 1, int limit = 20, int? categoryId}) async {
    try {
      final response = await _dio.get(
        '$apiUrl/products',
        queryParameters: {'page': page, 'limit': limit, 'category_id': categoryId},
      );

      print('API called: $apiUrl/products?page=$page&limit=$limit&category_id=$categoryId'); // Debug statement

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print('Response data: $data'); // Debug statement
        return data.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception('Failed to load products with status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('Error fetching products: $e\nStackTrace: $stackTrace'); // Enhanced debug statement
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Product> fetchProductDetails(int productId) async {
    try {
      final response = await _dio.get('$apiUrl/products/$productId');

      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load product details with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching product details: $e'); // Debug statement
      throw Exception('Error fetching product details: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await _dio.get('$apiUrl/search_products', queryParameters: {'q': query});

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print('Search response data: $data'); // Debug statement
        return data.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception('Failed to search products with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching products: $e'); // Debug statement
      throw Exception('Error searching products: $e');
    }
  }

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await _dio.get('$apiUrl/categories');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print('Category response data: $data'); // Debug statement
        return data.map((category) => Category.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load categories with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e'); // Debug statement
      throw Exception('Error fetching categories: $e');
    }
  }
}
