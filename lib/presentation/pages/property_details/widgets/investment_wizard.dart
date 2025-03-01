import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../domain/entities/property.dart';


class InvestmentWizard extends StatefulWidget {
  final Property property;
  final bool isAuthenticated;
  final Function onComplete;

  const InvestmentWizard({
    Key? key,
    required this.property,
    required this.isAuthenticated,
    required this.onComplete,
  }) : super(key: key);

  @override
  _InvestmentWizardState createState() => _InvestmentWizardState();
}

class _InvestmentWizardState extends State<InvestmentWizard> {
  final _formKey = GlobalKey<FormState>();
  
  // Step tracking
  int _currentStep = 0;
  final int _totalSteps = 4;
  
  // Investment details
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  int _tokens = 1;
  double _investmentAmount = 0;
  double _projectedAnnualReturn = 0;
  double _projectedFiveYearReturn = 0;
  
  // Investor details
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _netWorthController = TextEditingController();
  String _investmentExperience = 'Beginner';
  String _investmentGoal = 'Passive Income';
  String _investmentHorizon = '5+ years';
  
  // Payment and compliance
  String _selectedPaymentMethod = 'Bank Transfer';
  bool _agreedToTerms = false;
  bool _acknowledgedRisks = false;
  
  // Identity verification
  final TextEditingController _idNumberController = TextEditingController();
  String _idType = 'Passport';
  bool _hasUploadedDocument = false;
  
  List<String> investmentExperienceOptions = ['Beginner', 'Intermediate', 'Advanced', 'Professional'];
  List<String> investmentGoalOptions = ['Passive Income', 'Capital Appreciation', 'Portfolio Diversification', 'Wealth Preservation'];
  List<String> investmentHorizonOptions = ['1-2 years', '3-5 years', '5+ years', '10+ years'];
  List<String> paymentMethodOptions = ['Bank Transfer', 'Credit Card', 'Debit Card', 'Cryptocurrency'];
  List<String> idTypeOptions = ['Passport', 'Driver\'s License', 'National ID', 'Other Government ID'];

  @override
  void initState() {
    super.initState();
    _tokens = (widget.property.minInvestment / widget.property.tokenPrice).ceil();
    _tokenController.text = _tokens.toString();
    _updateCalculations();
    
    _tokenController.addListener(_onTokensChanged);
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _amountController.dispose();
    _incomeController.dispose();
    _netWorthController.dispose();
    _idNumberController.dispose();
    super.dispose();
  }

  void _onTokensChanged() {
    if (_tokenController.text.isEmpty) {
      setState(() {
        _tokens = 0;
        _investmentAmount = 0;
        _projectedAnnualReturn = 0;
        _projectedFiveYearReturn = 0;
      });
      return;
    }
    
    final newTokens = int.tryParse(_tokenController.text) ?? 0;
    if (newTokens != _tokens) {
      setState(() {
        _tokens = newTokens;
        _investmentAmount = _tokens * widget.property.tokenPrice;
        _amountController.text = _investmentAmount.toStringAsFixed(2);
        _updateCalculations();
      });
    }
  }

  void _onAmountChanged() {
    if (_amountController.text.isEmpty) {
      setState(() {
        _tokens = 0;
        _investmentAmount = 0;
        _projectedAnnualReturn = 0;
        _projectedFiveYearReturn = 0;
      });
      return;
    }
    
    final newAmount = double.tryParse(_amountController.text) ?? 0;
    if (newAmount != _investmentAmount) {
      final newTokens = (newAmount / widget.property.tokenPrice).floor();
      setState(() {
        _tokens = newTokens;
        _tokenController.text = _tokens.toString();
        _investmentAmount = _tokens * widget.property.tokenPrice;
        _updateCalculations();
      });
    }
  }

  void _updateCalculations() {
    setState(() {
      _projectedAnnualReturn = _investmentAmount * (widget.property.projectedReturn / 100);
      _projectedFiveYearReturn = _projectedAnnualReturn * 5;
    });
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _completeInvestment();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _completeInvestment() {
    // In a real application, this would send the investment data to a backend
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: AppDimensions.paddingM),
            _buildProgressIndicator(),
            SizedBox(height: AppDimensions.paddingL),
            _buildCurrentStep(),
            SizedBox(height: AppDimensions.paddingL),
            _buildNavButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(
          _getStepIcon(),
          color: AppColors.primary,
          size: 24,
        ),
        SizedBox(width: AppDimensions.paddingM),
        Text(
          _getStepTitle(),
          style: AppTextStyles.h4,
        ),
      ],
    );
  }

  IconData _getStepIcon() {
    switch (_currentStep) {
      case 0:
        return Icons.calculate;
      case 1:
        return Icons.person;
      case 2:
        return Icons.payment;
      case 3:
        return Icons.verified_user;
      default:
        return Icons.circle;
    }
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return "Investment Calculator";
      case 1:
        return "Investor Profile";
      case 2:
        return "Payment & Compliance";
      case 3:
        return "Identity Verification";
      default:
        return "Investment";
    }
  }

  Widget _buildProgressIndicator() {
    return Column(
      children: [
        Row(
          children: List.generate(_totalSteps, (index) {
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: index <= _currentStep ? AppColors.primary : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: AppDimensions.paddingS),
        Text(
          "Step ${_currentStep + 1} of $_totalSteps",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildInvestmentCalculator();
      case 1:
        return _buildInvestorProfile();
      case 2:
        return _buildPaymentAndCompliance();
      case 3:
        return _buildIdentityVerification();
      default:
        return Container();
    }
  }

  Widget _buildInvestmentCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How much would you like to invest in ${widget.property.title}?",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppDimensions.paddingL),
        
        // Number of tokens input
        Text(
          "Number of Tokens",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        TextFormField(
          controller: _tokenController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            hintText: "Enter number of tokens",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingM,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter number of tokens';
            }
            final tokens = int.tryParse(value);
            if (tokens == null || tokens <= 0) {
              return 'Please enter a valid number';
            }
            if (tokens * widget.property.tokenPrice < widget.property.minInvestment) {
              return 'Minimum investment is \$${widget.property.minInvestment}';
            }
            return null;
          },
        ),
        SizedBox(height: AppDimensions.paddingM),
        
        // Investment amount input
        Text(
          "Investment Amount",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        TextFormField(
          controller: _amountController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            hintText: "Enter investment amount",
            prefixText: "\$ ",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingM,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter investment amount';
            }
            final amount = double.tryParse(value);
            if (amount == null || amount <= 0) {
              return 'Please enter a valid amount';
            }
            if (amount < widget.property.minInvestment) {
              return 'Minimum investment is \$${widget.property.minInvestment}';
            }
            return null;
          },
        ),
        SizedBox(height: AppDimensions.paddingM),
        
        // Token price info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Token Price:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Text(
              "\$${widget.property.tokenPrice}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.paddingS),
        
        // Minimum investment info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Minimum Investment:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Text(
              "\$${widget.property.minInvestment}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        
        SizedBox(height: AppDimensions.paddingM),
        Divider(),
        SizedBox(height: AppDimensions.paddingM),
        
        // Projected returns
        Text(
          "Projected Returns",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        
        // Annual return
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Annual Return (${widget.property.projectedReturn}%):",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Text(
              "\$${_projectedAnnualReturn.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.paddingS),
        
        // 5-year return
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "5-Year Return:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Text(
              "\$${_projectedFiveYearReturn.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        
        SizedBox(height: AppDimensions.paddingM),
        
        // Disclaimer
        Text(
          "Projected returns are estimates based on historical data and market analysis. Actual returns may vary. Investment involves risk.",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildInvestorProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tell us about yourself as an investor",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Text(
          "This information helps us ensure this investment is suitable for your financial situation and goals.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingL),
        
        // Annual Income
        Text(
          "Annual Income (USD)",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        TextFormField(
          controller: _incomeController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            hintText: "Enter your annual income",
            prefixText: "\$ ",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your annual income';
            }
            return null;
          },
        ),
        SizedBox(height: AppDimensions.paddingM),
        
        // Net Worth
        Text(
          "Approximate Net Worth (USD)",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        TextFormField(
          controller: _netWorthController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            hintText: "Enter your approximate net worth",
            prefixText: "\$ ",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your approximate net worth';
            }
            return null;
          },
        ),
        SizedBox(height: AppDimensions.paddingM),
        
        // Investment Experience
        Text(
          "Investment Experience",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        DropdownButtonFormField<String>(
          value: _investmentExperience,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
          ),
          items: investmentExperienceOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _investmentExperience = newValue!;
            });
          },
        ),
        SizedBox(height: AppDimensions.paddingM),
        
        // Investment Goal
        Text(
          "Primary Investment Goal",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        DropdownButtonFormField<String>(
          value: _investmentGoal,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
          ),
          items: investmentGoalOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _investmentGoal = newValue!;
            });
          },
        ),
        SizedBox(height: AppDimensions.paddingM),
        
        // Investment Horizon
        Text(
          "Investment Time Horizon",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        DropdownButtonFormField<String>(
          value: _investmentHorizon,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
          ),
          items: investmentHorizonOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _investmentHorizon = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPaymentAndCompliance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method & Legal Compliance",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Text(
          "Select how you'd like to pay for your investment and review the legal requirements.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingL),
        
        // Payment Method
        Text(
          "Payment Method",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        DropdownButtonFormField<String>(
          value: _selectedPaymentMethod,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
          ),
          items: paymentMethodOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedPaymentMethod = newValue!;
            });
          },
        ),
        SizedBox(height: AppDimensions.paddingM),
        
        // Investment Summary
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingM),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Investment Summary",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: AppDimensions.paddingM),
              _buildSummaryRow("Property", widget.property.title),
              _buildSummaryRow("Tokens", "$_tokens"),
              _buildSummaryRow("Price per Token", "\$${widget.property.tokenPrice}"),
              _buildSummaryRow("Total Investment", "\$${_investmentAmount.toStringAsFixed(2)}"),
              _buildSummaryRow("Projected Annual Return", "\$${_projectedAnnualReturn.toStringAsFixed(2)}"),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.paddingL),
        
        // Terms Agreement
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: _agreedToTerms,
              onChanged: (value) {
                setState(() {
                  _agreedToTerms = value ?? false;
                });
              },
              activeColor: AppColors.primary,
            ),
            Expanded(
              child: Text(
                "I agree to the Terms of Service, Privacy Policy, and Investment Agreement governing this transaction.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.paddingM),
        
        // Risk Acknowledgement 
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: _acknowledgedRisks,
              onChanged: (value) {
                setState(() {
                  _acknowledgedRisks = value ?? false;
                });
              },
              activeColor: AppColors.primary,
            ),
            Expanded(
              child: Text(
                "I acknowledge that investing in land tokens involves risks, including potential loss of capital, and I have read and understood the risk disclosures provided.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityVerification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Identity Verification",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Text(
          "To comply with regulatory requirements, we need to verify your identity before processing your investment.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingL),
        
        // ID Type Selection
        Text(
          "ID Document Type",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        DropdownButtonFormField<String>(
          value: _idType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
          ),
          items: idTypeOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _idType = newValue!;
            });
          },
        ),
        SizedBox(height: AppDimensions.paddingM),
        
        // ID Number
        Text(
          "ID Number",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        TextFormField(
          controller: _idNumberController,
          decoration: InputDecoration(
            hintText: "Enter your ID number",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your ID number';
            }
            return null;
          },
        ),
        SizedBox(height: AppDimensions.paddingL),
        
        // Document Upload
        Text(
          "Upload Document",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(
              color: Colors.grey[400]!,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: () {
              // In a real app, this would trigger a file picker
              setState(() {
                _hasUploadedDocument = true;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _hasUploadedDocument ? Icons.check_circle : Icons.upload_file,
                  color: _hasUploadedDocument ? Colors.green : Colors.grey[600],
                  size: 32,
                ),
                SizedBox(height: AppDimensions.paddingS),
                Text(
                  _hasUploadedDocument ? "Document Uploaded" : "Click to Upload ID Document",
                  style: TextStyle(
                    color: _hasUploadedDocument ? Colors.green : Colors.grey[600],
                    fontWeight: _hasUploadedDocument ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        Text(
          "Please upload a clear, color copy of your ID document. Both sides must be visible.",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: AppDimensions.paddingL),
        
        // Selfie Upload
        Text(
          "Upload Selfie",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(
              color: Colors.grey[400]!,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: () {
              // In a real app, this would trigger the camera
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  color: Colors.grey[600],
                  size: 32,
                ),
                SizedBox(height: AppDimensions.paddingS),
                Text(
                  "Click to Take a Selfie",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        Text(
          "Please take a clear selfie holding your ID document next to your face.",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildNavButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentStep > 0)
          OutlinedButton(
            onPressed: _previousStep,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL, vertical: AppDimensions.paddingM),
            ),
            child: Text("Back"),
          )
        else
          SizedBox(),
        ElevatedButton(
          onPressed: () {
            if (_validateCurrentStep()) {
              _nextStep();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL, vertical: AppDimensions.paddingM),
          ),
          child: Text(_currentStep == _totalSteps - 1 ? "Complete Investment" : "Continue"),
        ),
      ],
    );
  }

  bool _validateCurrentStep() {
    if (_currentStep == 0) {
      // Validate investment amount
      if (_tokens <= 0 || _investmentAmount < widget.property.minInvestment) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Minimum investment is \${widget.property.minInvestment}'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
      return true;
    } else if (_currentStep == 1) {
      // Validate investor profile
      if (_incomeController.text.isEmpty || _netWorthController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please complete all required fields'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
      return true;
    } else if (_currentStep == 2) {
      // Validate payment and compliance
      if (!_agreedToTerms || !_acknowledgedRisks) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You must agree to the terms and acknowledge the risks to proceed'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
      return true;
    } else if (_currentStep == 3) {
      // Validate identity verification
      if (_idNumberController.text.isEmpty || !_hasUploadedDocument) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please complete identity verification'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
      return true;
    }
    return true;
  }
}