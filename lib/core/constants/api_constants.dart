// lib/core/constants/api_constants.dart

class ApiConstants {
  // Base URL
  static const String baseUrl = 'http://10.0.2.2:5000/api'; // For Android emulator
  // static const String baseUrl = 'http://localhost:5000/api'; // For iOS simulator
  // static const String baseUrl = 'https://your-production-url.com/api'; // For production

  // Authentication endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String refreshToken = '/auth/refresh-token';
  
  // User endpoints
  static const String currentUser = '/auth/me';
  static const String updatePassword = '/auth/update-password';
  
  // Property endpoints
  static const String properties = '/properties';
  static const String featuredProperties = '/properties/featured';
  static const String propertyCategories = '/properties/category';
  static const String myProperties = '/properties/user/my-properties';
  
  // Investment endpoints
  static const String investments = '/investments';
  static const String investmentStats = '/investments/stats';
  
  // Transaction endpoints
  static const String transactions = '/transactions';
  static const String transactionSummary = '/transactions/summary';
  static const String depositFunds = '/transactions/deposit';
  static const String withdrawFunds = '/transactions/withdraw';

  // Header keys
  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';
  
  // Header values
  static const String contentTypeJson = 'application/json';
  static const String bearerPrefix = 'Bearer ';
}