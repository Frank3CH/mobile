import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:esmv_store/utils/MLString.dart';

class MaintenanceProvider extends ChangeNotifier {
  static const String _baseUrl = '$backUrl'; // Replace with your API URL
  static const Duration _checkInterval = Duration(minutes: 3); // Check every minute

  bool _isUnderMaintenance = false;
  String? _maintenanceMessage;
  String? _estimatedEndTime;
  Timer? _periodicCheckTimer;
  bool _isChecking = false;

  bool get isUnderMaintenance => _isUnderMaintenance;
  String? get maintenanceMessage => _maintenanceMessage;
  String? get estimatedEndTime => _estimatedEndTime;

  /// Start periodic maintenance checks
  void startPeriodicCheck() {
    // Check immediately
    checkMaintenanceStatus();

    // Then check periodically
    _periodicCheckTimer?.cancel();
    _periodicCheckTimer = Timer.periodic(_checkInterval, (timer) {
      checkMaintenanceStatus();
    });
  }

  /// Stop periodic checks
  void stopPeriodicCheck() {
    _periodicCheckTimer?.cancel();
    _periodicCheckTimer = null;
  }

  /// Check maintenance status from API
  Future<void> checkMaintenanceStatus() async {
    if (_isChecking) return; // Prevent multiple simultaneous checks

    _isChecking = true;

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/maintenance/status'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 503) {
        final data = json.decode(response.body);

        final wasUnderMaintenance = _isUnderMaintenance;
        _isUnderMaintenance = data['isUnderMaintenance'] ?? false;
        _maintenanceMessage = data['message'];
        _estimatedEndTime = data['estimatedEndTime'];

        // Only notify if status changed
        if (wasUnderMaintenance != _isUnderMaintenance) {
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error checking maintenance status: $e');
      // On error, don't change current state (fail gracefully)
    } finally {
      _isChecking = false;
    }
  }

  @override
  void dispose() {
    stopPeriodicCheck();
    super.dispose();
  }
}