import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/services/auth_service.dart';
import 'package:ESMV_STORE/services/user_service.dart';
import 'package:ESMV_STORE/screens/MLDashboardScreen.dart';
import 'package:ESMV_STORE/model/MLUserProfile.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  bool _isLoading = false;
  MLUserProfile? _userProfile;

  bool get isLoading => _isLoading;
  MLUserProfile? get userProfile => _userProfile;

  Future<void> login(String email, String password, BuildContext context, bool rememberMe) async {
    _isLoading = true;
    notifyListeners();

    try {
      final String token = await _authService.login(email, password);
      await setValue('token', token);
      await setValue('isLoggedIn', true);

      final bool isAdmin = await _authService.isAdmin(token);
      await setValue('isAdmin', isAdmin);

      if (rememberMe) {
        await setValue('rememberMe', true);
      }

      // Fetch user profile
      await fetchUserProfile();

      MLDashboardScreen(isAdmin: isAdmin).launch(context, isNewTask: true);
    } catch (e) {
      print('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('données Incorrecte! Réessayez')),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      _userProfile = await _userService.fetchUserProfile();
      notifyListeners();
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  Future<void> checkTokenValidity(BuildContext context) async {
    String? token = getStringAsync('token');
    if (_authService.isTokenExpired(token)) {
      Navigator.pushNamedAndRemoveUntil(context, '/MLLoginScreen', (route) => false);
    }
  }

  Future<void> logout(BuildContext context) async {
    await removeKey('token');
    await removeKey('isLoggedIn');
    await removeKey('isAdmin');
    await removeKey('rememberMe');

    Navigator.pushNamedAndRemoveUntil(context, '/MLLoginScreen', (route) => false);
  }
}
