// lib/core/utils/api_service.dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class ApiResponse<T> {
  final T? data;
  final String? errorMessage;
  final bool isSuccess;
  final int statusCode;

  ApiResponse({
    this.data,
    this.errorMessage,
    required this.isSuccess,
    required this.statusCode,
  });

  factory ApiResponse.success(T data, int statusCode) {
    return ApiResponse(
      data: data,
      isSuccess: true,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.error(String errorMessage, int statusCode) {
    return ApiResponse(
      errorMessage: errorMessage,
      isSuccess: false,
      statusCode: statusCode,
    );
  }
}

class ApiService {
  final http.Client _client;
  String? _authToken;

  ApiService({
    http.Client? client,
    String? authToken,
  }) : _client = client ?? http.Client(), _authToken = authToken;

  // Set auth token
  void setToken(String token) {
    _authToken = token;
  }

  // Clear auth token
  void clearToken() {
    _authToken = null;
  }

  // Get request headers
  Map<String, String> _getHeaders({bool requiresAuth = true}) {
    final headers = {
      ApiConstants.contentTypeHeader: ApiConstants.contentTypeJson,
      ApiConstants.acceptHeader: ApiConstants.contentTypeJson,
    };

    if (requiresAuth && _authToken != null) {
      headers[ApiConstants.authorizationHeader] = '${ApiConstants.bearerPrefix}$_authToken';
    }

    return headers;
  }

  // GET request
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, String>? queryParams,
    bool requiresAuth = true,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl + endpoint).replace(
        queryParameters: queryParams,
      );

      final response = await _client.get(
        uri,
        headers: _getHeaders(requiresAuth: requiresAuth),
      );

      return _processResponse<T>(response, fromJson);
    } on SocketException {
      return ApiResponse.error('No internet connection', 0);
    } catch (e) {
      return ApiResponse.error('Something went wrong: ${e.toString()}', 500);
    }
  }

  // POST request
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    bool requiresAuth = true,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl + endpoint);

      final response = await _client.post(
        uri,
        headers: _getHeaders(requiresAuth: requiresAuth),
        body: body != null ? json.encode(body) : null,
      );

      return _processResponse<T>(response, fromJson);
    } on SocketException {
      return ApiResponse.error('No internet connection', 0);
    } catch (e) {
      return ApiResponse.error('Something went wrong: ${e.toString()}', 500);
    }
  }

  // PUT request
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    bool requiresAuth = true,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl + endpoint);

      final response = await _client.put(
        uri,
        headers: _getHeaders(requiresAuth: requiresAuth),
        body: body != null ? json.encode(body) : null,
      );

      return _processResponse<T>(response, fromJson);
    } on SocketException {
      return ApiResponse.error('No internet connection', 0);
    } catch (e) {
      return ApiResponse.error('Something went wrong: ${e.toString()}', 500);
    }
  }

  // PATCH request
  Future<ApiResponse<T>> patch<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    bool requiresAuth = true,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl + endpoint);

      final response = await _client.patch(
        uri,
        headers: _getHeaders(requiresAuth: requiresAuth),
        body: body != null ? json.encode(body) : null,
      );

      return _processResponse<T>(response, fromJson);
    } on SocketException {
      return ApiResponse.error('No internet connection', 0);
    } catch (e) {
      return ApiResponse.error('Something went wrong: ${e.toString()}', 500);
    }
  }

  // DELETE request
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    bool requiresAuth = true,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl + endpoint);

      final response = await _client.delete(
        uri,
        headers: _getHeaders(requiresAuth: requiresAuth),
      );

      return _processResponse<T>(response, fromJson);
    } on SocketException {
      return ApiResponse.error('No internet connection', 0);
    } catch (e) {
      return ApiResponse.error('Something went wrong: ${e.toString()}', 500);
    }
  }

  // Process the HTTP response
  ApiResponse<T> _processResponse<T>(
    http.Response response,
    T Function(dynamic)? fromJson,
  ) {
    try {
      final statusCode = response.statusCode;
      final hasBody = response.body.isNotEmpty;
      final decodedBody = hasBody ? json.decode(response.body) : null;

      if (statusCode >= 200 && statusCode < 300) {
        if (decodedBody == null) {
          return ApiResponse.success(null as T, statusCode);
        }

        if (fromJson != null) {
          final data = decodedBody['data'] ?? decodedBody;
          final parsedData = fromJson(data);
          return ApiResponse.success(parsedData, statusCode);
        } else {
          return ApiResponse.success(decodedBody as T, statusCode);
        }
      } else {
        String errorMessage;
        if (decodedBody != null && decodedBody.containsKey('message')) {
          errorMessage = decodedBody['message'];
        } else if (decodedBody != null && decodedBody.containsKey('error')) {
          errorMessage = decodedBody['error'];
        } else {
          errorMessage = 'An error occurred. Please try again.';
        }
        return ApiResponse.error(errorMessage, statusCode);
      }
    } catch (e) {
      debugPrint('Error processing response: ${e.toString()}');
      return ApiResponse.error('Failed to process response', response.statusCode);
    }
  }
}