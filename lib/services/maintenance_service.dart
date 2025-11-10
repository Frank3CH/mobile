import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:esmv_store/utils/MLString.dart';


class MaintenanceService {

  /// Checks if the app is under maintenance
  /// Returns a Map with 'isUnderMaintenance' and optional 'message'
  static Future<Map<String, dynamic>> checkMaintenanceStatus() async {
    try {
      final response = await http.get(
        Uri.parse('$backUrl/api/maintenance/status'),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 503) {
        print(json.decode(response.body));
        return json.decode(response.body);
      }

      // If server returns unexpected status, allow access
      return {'isUnderMaintenance': false};
    } catch (e) {
      print('Error checking maintenance status: $e');
      // On error, allow access (better user experience)
      return {'isUnderMaintenance': false};
    }
  }
}