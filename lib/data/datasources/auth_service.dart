// lib/data/datasources/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/api_constants.dart';
import '../../core/utils/api_service.dart';
import '../models/user_model.dart';

class AuthResponse {
  final UserModel? user;
  final String? token;
  final String? refreshToken;
  final String? errorMessage;
  final bool isSuccess;

  AuthResponse({
    this.user,
    this.token,
    this.refreshToken,
    this.errorMessage,
    required this.isSuccess,
  });
}

class AuthService {
  final ApiService _apiService;
  final SharedPreferences _preferences;
  
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';

  AuthService(this._apiService, this._preferences);

  // Login user
  Future<AuthResponse> login(String email, String password) async {
    final response = await _apiService.post(
      ApiConstants.login,
      body: {
        'email': email,
        'password': password,
      },
      requiresAuth: false,
    );

    if (response.isSuccess) {
      final data = response.data;
      final token = data['token'];
      final refreshToken = data['refreshToken'];
      final userData = data['data']['user'];
      
      final user = UserModel.fromJson(userData);
      
      // Save to shared preferences
      await _saveAuthData(token, refreshToken, user);
      
      // Set token in API service
      _apiService.setToken(token);
      
      return AuthResponse(
        user: user,
        token: token,
        refreshToken: refreshToken,
        isSuccess: true,
      );
    } else {
      return AuthResponse(
        errorMessage: response.errorMessage,
        isSuccess: false,
      );
    }
  }

  // Register user
  Future<AuthResponse> register(String name, String email, String password) async {
    final response = await _apiService.post(
      ApiConstants.register,
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
      requiresAuth: false,
    );

    if (response.isSuccess) {
      final data = response.data;
      final token = data['token'];
      final refreshToken = data['refreshToken'];
      final userData = data['data']['user'];
      
      final user = UserModel.fromJson(userData);
      
      // Save to shared preferences
      await _saveAuthData(token, refreshToken, user);
      
      // Set token in API service
      _apiService.setToken(token);
      
      return AuthResponse(
        user: user,
        token: token,
        refreshToken: refreshToken,
        isSuccess: true,
      );
    } else {
      return AuthResponse(
        errorMessage: response.errorMessage,
        isSuccess: false,
      );
    }
  }

  // Get current user from API
  Future<AuthResponse> getCurrentUser() async {
    // First check if we have a token
    final token = _preferences.getString(_tokenKey);
    
    if (token == null) {
      return AuthResponse(isSuccess: false);
    }
    
    // Set token and make API call
    _apiService.setToken(token);
    
    final response = await _apiService.get(ApiConstants.currentUser);
    
    if (response.isSuccess) {
      final userData = response.data['user'];
      final user = UserModel.fromJson(userData);
      
      // Update stored user data
      await _preferences.setString(_userKey, user.toJson().toString());
      
      return AuthResponse(
        user: user,
        token: token,
        refreshToken: _preferences.getString(_refreshTokenKey),
        isSuccess: true,
      );
    } else if (response.statusCode == 401) {
      // Try refreshing token
      return await _refreshToken();
    } else {
      return AuthResponse(
        errorMessage: response.errorMessage,
        isSuccess: false,
      );
    }
  }

  // Get current user from local storage
  Future<UserModel?> getLocalUser() async {
    final userJson = _preferences.getString(_userKey);
    if (userJson != null) {
      try {
        return UserModel.fromJson(userJson as Map<String, dynamic>);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return _preferences.getString(_tokenKey) != null;
  }

  // Log out user
  Future<void> logout() async {
    // Clear token in API service
    _apiService.clearToken();
    
    // Clear shared preferences
    await _preferences.remove(_tokenKey);
    await _preferences.remove(_refreshTokenKey);
    await _preferences.remove(_userKey);
  }

  // Request password reset
  Future<ApiResponse<void>> forgotPassword(String email) async {
    return await _apiService.post(
      ApiConstants.forgotPassword,
      body: {'email': email},
      requiresAuth: false,
    );
  }

  // Reset password
  Future<ApiResponse<void>> resetPassword(String token, String password) async {
    return await _apiService.patch(
      '${ApiConstants.resetPassword}/$token',
      body: {'password': password},
      requiresAuth: false,
    );
  }

  // Change password
  Future<ApiResponse<void>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    return await _apiService.patch(
      ApiConstants.updatePassword,
      body: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
  }

  // Refresh token
  Future<AuthResponse> _refreshToken() async {
    final refreshToken = _preferences.getString(_refreshTokenKey);
    
    if (refreshToken == null) {
      await logout();
      return AuthResponse(
        errorMessage: 'Session expired. Please log in again.',
        isSuccess: false,
      );
    }
    
    final response = await _apiService.post(
      ApiConstants.refreshToken,
      body: {'refreshToken': refreshToken},
      requiresAuth: false,
    );
    
    if (response.isSuccess) {
      final data = response.data;
      final newToken = data['token'];
      final newRefreshToken = data['refreshToken'];
      
      // Save new tokens
      await _preferences.setString(_tokenKey, newToken);
      await _preferences.setString(_refreshTokenKey, newRefreshToken);
      
      // Set new token in API service
      _apiService.setToken(newToken);
      
      // Try to get user data again
      return await getCurrentUser();
    } else {
      // If refresh token also fails, log out
      await logout();
      return AuthResponse(
        errorMessage: 'Session expired. Please log in again.',
        isSuccess: false,
      );
    }
  }

  // Save authentication data to SharedPreferences
  Future<void> _saveAuthData(
    String token,
    String refreshToken,
    UserModel user,
  ) async {
    await _preferences.setString(_tokenKey, token);
    await _preferences.setString(_refreshTokenKey, refreshToken);
    await _preferences.setString(_userKey, user.toJson().toString());
  }
}