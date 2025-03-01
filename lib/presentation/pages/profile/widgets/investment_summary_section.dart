// lib/presentation/pages/profile/widgets/investment_summary_section.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';

class InvestmentSummarySection extends StatelessWidget {
  // Sample data - in a real app, this would come from an API call
  final List<Map<String, dynamic>> investments = [
    {
      'property': 'Urban Development Land - Downtown Metro',
      'location': 'Phoenix, Arizona',
      'investedAmount': 2500,
      'currentValue': 2850,
      'tokens': 50,
      'purchaseDate': '2025-01-15',
      'annualReturn': 14.0,
    },
    {
      'property': 'Commercial District - Tech Corridor',
      'location': 'Austin, Texas',
      'investedAmount': 5000,
      'currentValue': 6250,
      'tokens': 50,
      'purchaseDate': '2024-11-22',
      'annualReturn': 25.0,
    },
    {
      'property': 'Residential Development - Lakeside Community',
      'location': 'Nashville, Tennessee',
      'investedAmount': 3000,
      'currentValue': 3450,
      'tokens': 40,
      'purchaseDate': '2025-02-10',
      'annualReturn': 15.0,
    },
    {
      'property': 'Agricultural Farmland - Riverside County',
      'location': 'Riverside, California',
      'investedAmount': 2000,
      'currentValue': 2150,
      'tokens': 200,
      'purchaseDate': '2024-12-05',
      'annualReturn': 7.5,
    },
  ];
  
  final Map<String, dynamic> portfolioStats = {
    'totalInvested': 12500,
    'currentValue': 14700,
    'totalReturn': 2200,
    'returnPercentage': 17.6,
    'annualizedReturn': 12.8,
    'totalProperties': 4,
    'totalTokens': 340,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Investment Portfolio",
          style: AppTextStyles.h4,
        ),
        SizedBox(height: AppDimensions.paddingM),
        _buildPortfolioOverview(),
        SizedBox(height: AppDimensions.paddingL),
        _buildInvestmentPerformanceChart(context),
        SizedBox(height: AppDimensions.paddingL),
        _buildInvestmentsList(context),
        SizedBox(height: AppDimensions.paddingXL),
        _buildInvestmentHistory(),
      ],
    );
  }

  Widget _buildPortfolioOverview() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Invested",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "\$${portfolioStats['totalInvested']}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Current Value",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "\$${portfolioStats['currentValue']}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingL),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                "Total Return",
                "\$${portfolioStats['totalReturn']}",
                positiveColor: true,
              ),
              _buildStatItem(
                "Return %",
                "${portfolioStats['returnPercentage']}%",
                positiveColor: true,
              ),
              _buildStatItem(
                "Properties",
                "${portfolioStats['totalProperties']}",
              ),
              _buildStatItem(
                "Tokens",
                "${portfolioStats['totalTokens']}",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {bool positiveColor = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: positiveColor ? Colors.green : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentPerformanceChart(BuildContext context) {
    // In a real app, you would use a charting library like fl_chart here
    return Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Portfolio Growth",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: AppDimensions.paddingM),
          Expanded(
            child: Center(
              child: Text(
                "Performance chart will appear here",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your Investments",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.filter_list, size: 16),
              label: Text("Filter"),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.paddingM),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: investments.map((investment) {
              return _buildInvestmentItem(context, investment);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentItem(BuildContext context, Map<String, dynamic> investment) {
    final isPositive = investment['currentValue'] >= investment['investedAmount'];
    final returnAmount = investment['currentValue'] - investment['investedAmount'];
    final returnPercentage = (returnAmount / investment['investedAmount']) * 100;
    
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  investment['property'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  investment['location'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Purchased on ${_formatDate(investment['purchaseDate'])} • ${investment['tokens']} tokens",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${investment['currentValue']}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "\$${investment['investedAmount']} invested",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isPositive ? Colors.green : Colors.red,
                      size: 12,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${returnPercentage.toStringAsFixed(1)}%",
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Investment History",
          style: AppTextStyles.h4,
        ),
        SizedBox(height: AppDimensions.paddingM),
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingL),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              _buildHistoryItem(
                date: "2025-02-10",
                type: "Purchase",
                property: "Residential Development - Lakeside Community",
                amount: 3000,
                tokens: 40,
              ),
              _buildHistoryItem(
                date: "2025-01-30",
                type: "Dividend",
                property: "Commercial District - Tech Corridor",
                amount: 125,
                tokens: 0,
              ),
              _buildHistoryItem(
                date: "2025-01-15",
                type: "Purchase",
                property: "Urban Development Land - Downtown Metro",
                amount: 2500,
                tokens: 50,
              ),
              _buildHistoryItem(
                date: "2024-12-05",
                type: "Purchase",
                property: "Agricultural Farmland - Riverside County",
                amount: 2000,
                tokens: 200,
              ),
              _buildHistoryItem(
                date: "2024-11-22",
                type: "Purchase",
                property: "Commercial District - Tech Corridor",
                amount: 5000,
                tokens: 50,
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Center(
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.history, size: 16),
            label: Text("View Complete History"),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem({
    required String date,
    required String type,
    required String property,
    required double amount,
    required int tokens,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getHistoryTypeColor(type).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                _getHistoryTypeIcon(type),
                color: _getHistoryTypeColor(type),
                size: 20,
              ),
            ),
          ),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$type${tokens > 0 ? ' - $tokens tokens' : ''}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  property,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\${amount.toInt()}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: type == "Dividend" ? Colors.green : Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                _formatDate(date),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getHistoryTypeIcon(String type) {
    switch (type) {
      case "Purchase":
        return Icons.add_circle;
      case "Sale":
        return Icons.remove_circle;
      case "Dividend":
        return Icons.attach_money;
      default:
        return Icons.swap_horiz;
    }
  }

  Color _getHistoryTypeColor(String type) {
    switch (type) {
      case "Purchase":
        return Colors.blue;
      case "Sale":
        return Colors.orange;
      case "Dividend":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String dateStr) {
    final parts = dateStr.split('-');
    return '${parts[1]}/${parts[2]}/${parts[0]}';
  }
}