// lib/data/datasources/investment_service.dart
import '../../core/constants/api_constants.dart';
import '../../core/utils/api_service.dart';

class InvestmentModel {
  final String id;
  final String propertyId;
  final int tokensPurchased;
  final double investmentAmount;
  final DateTime purchaseDate;
  final double currentValue;
  
  InvestmentModel({
    required this.id,
    required this.propertyId,
    required this.tokensPurchased,
    required this.investmentAmount,
    required this.purchaseDate,
    required this.currentValue,
  });
  
  factory InvestmentModel.fromJson(Map<String, dynamic> json) {
    return InvestmentModel(
      id: json['_id'],
      propertyId: json['property']['_id'],
      tokensPurchased: json['tokensPurchased'],
      investmentAmount: json['investmentAmount'].toDouble(),
      purchaseDate: DateTime.parse(json['purchaseDate']),
      currentValue: json['currentValue'].toDouble(),
    );
  }
}

class InvestmentStats {
  final double totalInvestment;
  final double totalCurrentValue;
  final double totalReturn;
  
  InvestmentStats({
    required this.totalInvestment,
    required this.totalCurrentValue,
    required this.totalReturn,
  });
  
  factory InvestmentStats.fromJson(Map<String, dynamic> json) {
    return InvestmentStats(
      totalInvestment: json['totalInvestment'].toDouble(),
      totalCurrentValue: json['totalCurrentValue'].toDouble(),
      totalReturn: json['totalCurrentValue'].toDouble() - json['totalInvestment'].toDouble(),
    );
  }
}

class InvestmentService {
  final ApiService _apiService;

  InvestmentService(this._apiService);

  // Get user investments
  Future<ApiResponse<List<InvestmentModel>>> getUserInvestments() async {
    final response = await _apiService.get(
      ApiConstants.investments,
      fromJson: (json) {
        final List<dynamic> investmentsJson = json['investments'];
        return investmentsJson
            .map((investmentJson) => InvestmentModel.fromJson(investmentJson))
            .toList();
      },
    );
    
    return response;
  }

  // Get investment by ID
  Future<ApiResponse<InvestmentModel>> getInvestmentById(String id) async {
    final response = await _apiService.get(
      '${ApiConstants.investments}/$id',
      fromJson: (json) => InvestmentModel.fromJson(json['investment']),
    );
    
    return response;
  }

  // Make an investment
  Future<ApiResponse<InvestmentModel>> makeInvestment(String propertyId, int tokens) async {
    final response = await _apiService.post(
      ApiConstants.investments,
      body: {
        'property': propertyId,
        'tokensPurchased': tokens,
      },
      fromJson: (json) => InvestmentModel.fromJson(json['investment']),
    );
    
    return response;
  }

  // Create sell order
  Future<ApiResponse<dynamic>> createSellOrder(String investmentId, int quantity, double price) async {
    final response = await _apiService.post(
      '${ApiConstants.investments}/$investmentId/sell',
      body: {
        'quantity': quantity,
        'price': price,
      },
    );
    
    return response;
  }

  // Cancel sell order
  Future<ApiResponse<dynamic>> cancelSellOrder(String investmentId, String orderId) async {
    final response = await _apiService.patch(
      '${ApiConstants.investments}/$investmentId/sell/$orderId/cancel',
    );
    
    return response;
  }

  // Get investment statistics
  Future<ApiResponse<InvestmentStats>> getInvestmentStats() async {
    final response = await _apiService.get(
      ApiConstants.investmentStats,
      fromJson: (json) => InvestmentStats.fromJson(json['stats']),
    );
    
    return response;
  }
}