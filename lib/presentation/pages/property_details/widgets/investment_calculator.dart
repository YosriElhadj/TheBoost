// presentation/pages/property_details/widgets/investment_calculator.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../domain/entities/property.dart';
import 'investment_wizard.dart'; // Import the new wizard component

class InvestmentCalculator extends StatefulWidget {
  final Property property;
  final bool isAuthenticated;

  const InvestmentCalculator({
    Key? key,
    required this.property,
    required this.isAuthenticated,
  }) : super(key: key);

  @override
  _InvestmentCalculatorState createState() => _InvestmentCalculatorState();
}

class _InvestmentCalculatorState extends State<InvestmentCalculator> {
  bool _showWizard = false;

  @override
  Widget build(BuildContext context) {
    if (_showWizard) {
      return InvestmentWizard(
        property: widget.property,
        isAuthenticated: widget.isAuthenticated,
        onComplete: _handleInvestmentComplete,
      );
    }

    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildPropertyStats(),
          _buildDivider(),
          _buildInvestmentHighlights(),
          _buildDivider(),
          _buildInvestButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Investment Opportunity",
          style: AppTextStyles.h4,
        ),
        SizedBox(height: AppDimensions.paddingS),
        Text(
          "Start investing in ${widget.property.title} with as little as \$${widget.property.minInvestment}",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyStats() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppDimensions.paddingL),
      padding: EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Column(
        children: [
          _buildStatRow(
            "Token Price",
            "\$${widget.property.tokenPrice}",
            "Min Investment",
            "\$${widget.property.minInvestment}",
          ),
          SizedBox(height: AppDimensions.paddingM),
          _buildStatRow(
            "Annual Return",
            "${widget.property.projectedReturn}%",
            "Risk Level",
            widget.property.riskLevel,
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label1, String value1, String label2, String value2) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label2,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value2,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: AppDimensions.paddingXL,
      color: Colors.grey[300],
    );
  }

  Widget _buildInvestmentHighlights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Highlights",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        _buildHighlightItem("Fractional Ownership", "Purchase tokens representing partial ownership of this property"),
        _buildHighlightItem("High Liquidity", "Easily trade your tokens on our marketplace"),
        _buildHighlightItem("Transparent Fees", "Only 2% transaction fee and 0.5% annual management fee"),
        _buildHighlightItem("Automatic Dividends", "Receive returns directly to your wallet"),
      ],
    );
  }

  Widget _buildHighlightItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.primary,
            size: 20,
          ),
          SizedBox(width: AppDimensions.paddingS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestButton() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _startInvestmentFlow,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Invest Now",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Text(
          "Investment subject to terms and conditions. Potential returns are not guaranteed. Past performance is not indicative of future results.",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _startInvestmentFlow() {
    if (!widget.isAuthenticated) {
      _showLoginDialog();
      return;
    }
    
    setState(() {
      _showWizard = true;
    });
  }

  void _handleInvestmentComplete() {
    // Show success dialog and redirect
    _showSuccessDialog();
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Required'),
        content: Text('You need to be logged in to make an investment. Would you like to login now?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/auth');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            SizedBox(width: AppDimensions.paddingS),
            Text('Investment Successful'),
          ],
        ),
        content: Text(
          'Congratulations! Your investment in ${widget.property.title} has been successfully processed. You can view your investment in your dashboard.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text('Go to Dashboard'),
          ),
        ],
      ),
    );
  }
}