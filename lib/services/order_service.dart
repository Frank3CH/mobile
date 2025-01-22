import 'package:esmv_store/model/Facture.dart';
import 'package:esmv_store/model/MLUserProfile.dart';
import 'package:esmv_store/services/user_service.dart';
import 'package:esmv_store/utils/MLString.dart';
import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/model/Commande.dart';

class OrderService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: backUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  Future<Response> createOrder(Map<String, dynamic> orderData) async {
    final url = '/api/orders';
    String? token = getStringAsync('token');
    print(orderData);
    try {
      final response = await _dio.post(
        url,
        data: orderData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data}');
      throw e;
    }
  }

  Future<Response> getOrders() async {
    String? token = getStringAsync('token');
    return await _dio.get('/api/orders', options: Options(
      headers: {'Authorization': 'Bearer $token'},
    ));
  }

  Future<Response> getOrderDetails(int orderId) async {
    String? token = getStringAsync('token');
    return await _dio.get('/api/order/$orderId', options: Options(
      headers: {'Authorization': 'Bearer $token'},
    ));
  }

  Future<Response> updateOrder(int orderId, Map<String, dynamic> orderData) async {
    String? token = getStringAsync('token');
    return await _dio.put('/api/order/$orderId', data: orderData, options: Options(
      headers: {'Authorization': 'Bearer $token'},
    ));
  }

  Future<Response> getOrdersByPharmacien() async {
    String? token = getStringAsync('token');


    try {
      final response = await _dio.get(
        '/api/User/orders',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Commande> commandes = (response.data as List).map((e) => Commande.fromJson(e)).toList();
        return Response(
          requestOptions: response.requestOptions,
          data: commandes,
          statusCode: 200,
        );
      } else {
        return Response(
          requestOptions: response.requestOptions,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
        );
      }
    } catch (e) {
      print('Error: $e this');
      return Response(
        requestOptions: RequestOptions(path: '/api/User/orders'),
        statusCode: 500,
        statusMessage: 'Internal Server Error',
      );
    }
  }

  Future<List<dynamic>> fetchPendingOrders() async {

    String? token = getStringAsync('token');
    try {
      final response = await _dio.get(
        '/api/orders/pending',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load orders with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<void> validateOrder(int orderId) async {
    String? token = getStringAsync('token');
    try {
      await _dio.post(
        '/api/order/validate/$orderId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to validate order: $e');
    }
  }

  Future<void> validateOrderWithQuantities(int orderId, List<Map<String, dynamic>> productUpdates) async {
    String? token = getStringAsync('token');
    try {
      await _dio.post(
        '/api/order/validate-with-quantities/$orderId',
        data: {
          'products': productUpdates,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to validate order with quantities: $e');
    }
  }

  Future<void> rejectOrder(int orderId) async {
    String? token = getStringAsync('token');
    try {
      await _dio.post(
        '/api/order/reject/$orderId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to reject order: $e');
    }
  }

  Future<void> updateOrderQuantity(int orderId, int productId, int quantity) async {
    String? token = getStringAsync('token');
    try {
      await _dio.post(
        '/api/order/update-quantity/$orderId',
        data: {
          'product_id': productId,
          'quantity': quantity,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to update order quantity: $e');
    }
  }
  Future<List<dynamic>> fetchRejectedOrders() async {
    String? token = getStringAsync('token');
    try {
      final response = await _dio.get(
        '/api/orders/rejected',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      print(response);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load rejected orders with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load rejected orders: $e');
    }
  }

  Future<List<dynamic>> fetchClosedOrders() async {
    String? token = getStringAsync('token');
    try {
      final response = await _dio.get(
        '/api/orders/closed',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load closed orders with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load closed orders: $e');
    }
  }

  Future<Response> getUserOrders() async {
    String? token = getStringAsync('token');
    return await _dio.get(
      '/api/User/orders',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }


  Future<List<dynamic>> fetchValidatedOrders() async {
    String? token = getStringAsync('token');
    try {
      final response = await _dio.get(
        '/api/orders/validated',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load closed orders with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load closed orders: $e');
    }
  }


  Future<List<Facture>> fetchFactures() async {
    try {
      // First, fetch the user profile to get the codeWave
      MLUserProfile userProfile = await UserService().fetchUserProfile();

      // Use the codeWave from the user profile in the request body
      String? codeWave = userProfile.Codewave;

      if (codeWave == null) {
        throw Exception('Codewave is missing');
      }

      // Prepare the request body with the codeWave
      final requestBody = {
        'codeWave': codeWave,
      };

      // Make the POST request with the codeWave
      final response = await _dio.post(
        'http://102.214.129.238:8880/api/User/get-solde-detail',
        data: requestBody,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<dynamic> facturesData = responseData['soldeDetails'] ?? []; // Adjust based on actual key
        return facturesData.map((item) => Facture.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load factures');
      }
    } catch (e) {
      throw Exception('Error fetching factures: $e');
    }
  }

}
