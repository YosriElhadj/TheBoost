// lib/data/datasources/property_service.dart
import '../../core/constants/api_constants.dart';
import '../../core/utils/api_service.dart';
import '../models/property_model.dart';

class PropertyService {
  final ApiService _apiService;

  PropertyService(this._apiService);

  // Get all properties
  Future<ApiResponse<List<PropertyModel>>> getProperties({
    String? category,
    double? minPrice,
    double? maxPrice,
    double? minReturn,
    double? maxReturn,
    List<String>? riskLevels,
  }) async {
    // Build query parameters
    final queryParams = <String, String>{};
    
    if (category != null && category != 'All') {
      queryParams['category'] = category;
    }
    
    if (minPrice != null) {
      queryParams['minPrice'] = minPrice.toString();
    }
    
    if (maxPrice != null) {
      queryParams['maxPrice'] = maxPrice.toString();
    }
    
    if (minReturn != null) {
      queryParams['minReturn'] = minReturn.toString();
    }
    
    if (maxReturn != null) {
      queryParams['maxReturn'] = maxReturn.toString();
    }
    
    if (riskLevels != null && riskLevels.isNotEmpty) {
      queryParams['riskLevels'] = riskLevels.join(',');
    }
    
    final response = await _apiService.get(
      ApiConstants.properties,
      queryParams: queryParams,
      fromJson: (json) {
        final List<dynamic> propertiesJson = json['properties'];
        return propertiesJson
            .map((propertyJson) => PropertyModel.fromJson(propertyJson))
            .toList();
      },
    );
    
    return response;
  }

  // Get property by ID
  Future<ApiResponse<PropertyModel>> getPropertyById(String id) async {
    final response = await _apiService.get(
      '${ApiConstants.properties}/$id',
      fromJson: (json) => PropertyModel.fromJson(json['property']),
    );
    
    return response;
  }

  // Get featured properties
  Future<ApiResponse<List<PropertyModel>>> getFeaturedProperties() async {
    final response = await _apiService.get(
      ApiConstants.featuredProperties,
      fromJson: (json) {
        final List<dynamic> propertiesJson = json['properties'];
        return propertiesJson
            .map((propertyJson) => PropertyModel.fromJson(propertyJson))
            .toList();
      },
    );
    
    return response;
  }

  // Get properties by category
  Future<ApiResponse<List<PropertyModel>>> getPropertiesByCategory(String category) async {
    final response = await _apiService.get(
      '${ApiConstants.propertyCategories}/$category',
      fromJson: (json) {
        final List<dynamic> propertiesJson = json['properties'];
        return propertiesJson
            .map((propertyJson) => PropertyModel.fromJson(propertyJson))
            .toList();
      },
    );
    
    return response;
  }

  // Get user's properties
  Future<ApiResponse<List<PropertyModel>>> getUserProperties() async {
    final response = await _apiService.get(
      ApiConstants.myProperties,
      fromJson: (json) {
        final List<dynamic> propertiesJson = json['properties'];
        return propertiesJson
            .map((propertyJson) => PropertyModel.fromJson(propertyJson))
            .toList();
      },
    );
    
    return response;
  }

  // Create property
  Future<ApiResponse<PropertyModel>> createProperty(Map<String, dynamic> propertyData) async {
    final response = await _apiService.post(
      ApiConstants.properties,
      body: propertyData,
      fromJson: (json) => PropertyModel.fromJson(json['property']),
    );
    
    return response;
  }

  // Update property
  Future<ApiResponse<PropertyModel>> updateProperty(String id, Map<String, dynamic> propertyData) async {
    final response = await _apiService.patch(
      '${ApiConstants.properties}/$id',
      body: propertyData,
      fromJson: (json) => PropertyModel.fromJson(json['property']),
    );
    
    return response;
  }

  // Delete property
  Future<ApiResponse<void>> deleteProperty(String id) async {
    return await _apiService.delete('${ApiConstants.properties}/$id');
  }
}