// lib/presentation/pages/profile/widgets/wallet_section.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class WalletSection extends StatefulWidget {
  @override
  _WalletSectionState createState() => _WalletSectionState();
}

class _WalletSectionState extends State<WalletSection> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final _depositFormKey = GlobalKey<FormState>();
  final _withdrawFormKey = GlobalKey<FormState>();
  
  final TextEditingController _depositAmountController = TextEditingController();
  final TextEditingController _withdrawAmountController = TextEditingController();
  
  String _selectedDepositMethod = 'Bank Transfer';
  String _selectedWithdrawMethod = 'Bank Account';
  
  final List<String> depositMethods = ['Bank Transfer', 'Credit Card', 'Debit Card', 'Cryptocurrency'];
  final List<String> withdrawMethods = ['Bank Account', 'Cryptocurrency Wallet'];
  
  final List<Map<String, dynamic>> transactions = [
    {
      'type': 'Deposit',
      'status': 'Completed',
      'amount': 5000.0,
      'date': '2025-02-20',
      'method': 'Bank Transfer',
      'reference': 'DEP12345',
    },
    {
      'type': 'Investment',
      'status': 'Completed',
      'amount': -3000.0,
      'date': '2025-02-10',
      'property': 'Residential Development - Lakeside Community',
      'reference': 'INV12345',
    },
    {
      'type': 'Deposit',
      'status': 'Completed',
      'amount': 2000.0,
      'date': '2025-01-15',
      'method': 'Credit Card',
      'reference': 'DEP12346',
    },
    {
      'type': 'Investment',
      'status': 'Completed',
      'amount': -2500.0,
      'date': '2025-01-15',
      'property': 'Urban Development Land - Downtown Metro',
      'reference': 'INV12346',
    },
    {
      'type': 'Dividend',
      'status': 'Completed',
      'amount': 125.0,
      'date': '2025-01-30',
      'property': 'Commercial District - Tech Corridor',
      'reference': 'DIV12345',
    },
    {
      'type': 'Withdrawal',
      'status': 'Pending',
      'amount': -1000.0,
      'date': '2025-02-28',
      'method': 'Bank Account',
      'reference': 'WIT12345',
    },
  ];
  
  // Payment methods
  final List<Map<String, dynamic>> paymentMethods = [
    {
      'type': 'bank',
      'name': 'Chase Bank',
      'number': '****6789',
      'isPrimary': true,
      'isVerified': true,
    },
    {
      'type': 'card',
      'name': 'Visa Credit Card',
      'number': '****4321',
      'expiry': '05/26',
      'isPrimary': false,
      'isVerified': true,
    },
    {
      'type': 'crypto',
      'name': 'Ethereum Wallet',
      'address': '0x71C7656EC7ab88b098defB751B7401B5f6d8976F',
      'isPrimary': false,
      'isVerified': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _depositAmountController.dispose();
    _withdrawAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Wallet & Payments",
          style: AppTextStyles.h4,
        ),
        SizedBox(height: AppDimensions.paddingM),
        _buildWalletBalance(),
        SizedBox(height: AppDimensions.paddingXL),
        _buildDepositWithdrawTabs(),
        SizedBox(height: AppDimensions.paddingXL),
        _buildPaymentMethods(),
        SizedBox(height: AppDimensions.paddingXL),
        _buildTransactionHistory(),
      ],
    );
  }

  Widget _buildWalletBalance() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Balance",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "\$3,625.00",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  AppButton(
                    text: "Deposit",
                    onPressed: () {
                      _tabController.animateTo(0);
                    },
                    type: ButtonType.primary,
                    icon: Icons.add,
                  ),
                  SizedBox(width: AppDimensions.paddingM),
                  AppButton(
                    text: "Withdraw",
                    onPressed: () {
                      _tabController.animateTo(1);
                    },
                    type: ButtonType.outline,
                    icon: Icons.remove,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingL),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBalanceItem(
                label: "Total Invested",
                value: "\$10,500.00",
              ),
              _buildBalanceItem(
                label: "Pending Transfers",
                value: "\$1,000.00",
              ),
              _buildBalanceItem(
                label: "Total Earned",
                value: "\$125.00",
                isPositive: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem({
    required String label,
    required String value,
    bool isPositive = false,
  }) {
    return Column(
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
            color: isPositive ? Colors.green : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildDepositWithdrawTabs() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.primary,
                tabs: [
                  Tab(text: "Deposit Funds"),
                  Tab(text: "Withdraw Funds"),
                ],
              ),
              SizedBox(
                height: 350,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildDepositForm(),
                    _buildWithdrawForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDepositForm() {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Form(
        key: _depositFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Deposit funds to your wallet",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: AppDimensions.paddingM),
            AppTextField(
              label: "Amount",
              controller: _depositAmountController,
              prefixIcon: Icons.attach_money,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                if (amount < 100) {
                  return 'Minimum deposit is \$100';
                }
                return null;
              },
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              "Payment Method",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: AppDimensions.paddingS),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM,
                vertical: AppDimensions.paddingS,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: DropdownButton<String>(
                value: _selectedDepositMethod,
                isExpanded: true,
                underline: SizedBox(),
                items: depositMethods.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedDepositMethod = newValue;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: AppDimensions.paddingL),
            AppButton(
              text: "Deposit Funds",
              onPressed: () {
                if (_depositFormKey.currentState!.validate()) {
                  _showConfirmationDialog(
                    "Deposit Confirmation",
                    "Are you sure you want to deposit \$${_depositAmountController.text} via $_selectedDepositMethod?",
                    () {
                      // Process deposit
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deposit initiated successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _depositAmountController.clear();
                    },
                  );
                }
              },
              isFullWidth: true,
              type: ButtonType.primary,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              "Funds are typically available within 1-3 business days, depending on the payment method.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithdrawForm() {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Form(
        key: _withdrawFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Withdraw funds from your wallet",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: AppDimensions.paddingM),
            AppTextField(
              label: "Amount",
              controller: _withdrawAmountController,
              prefixIcon: Icons.attach_money,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                if (amount < 100) {
                  return 'Minimum withdrawal is \$100';
                }
                if (amount > 3625) {
                  return 'Insufficient funds. Maximum available: \$3,625.00';
                }
                return null;
              },
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              "Withdrawal Method",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: AppDimensions.paddingS),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM,
                vertical: AppDimensions.paddingS,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: DropdownButton<String>(
                value: _selectedWithdrawMethod,
                isExpanded: true,
                underline: SizedBox(),
                items: withdrawMethods.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedWithdrawMethod = newValue;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: AppDimensions.paddingL),
            AppButton(
              text: "Withdraw Funds",
              onPressed: () {
                if (_withdrawFormKey.currentState!.validate()) {
                  _showConfirmationDialog(
                    "Withdrawal Confirmation",
                    "Are you sure you want to withdraw \$${_withdrawAmountController.text} to your $_selectedWithdrawMethod?",
                    () {
                      // Process withdrawal
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Withdrawal initiated successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _withdrawAmountController.clear();
                    },
                  );
                }
              },
              isFullWidth: true,
              type: ButtonType.primary,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              "Withdrawals are typically processed within 1-3 business days. A fee of \$5 applies to withdrawals under \$500.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payment Methods",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            AppButton(
              text: "Add New",
              onPressed: () {
                // Add new payment method logic
              },
              type: ButtonType.outline,
              icon: Icons.add,
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
            children: paymentMethods.map((method) {
              return _buildPaymentMethodItem(method);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodItem(Map<String, dynamic> method) {
    IconData icon;
    String subtitle;
    
    switch (method['type']) {
      case 'bank':
        icon = Icons.account_balance;
        subtitle = "Account: ${method['number']}";
        break;
      case 'card':
        icon = Icons.credit_card;
        subtitle = "${method['number']} • Expires ${method['expiry']}";
        break;
      case 'crypto':
        icon = Icons.currency_bitcoin;
        subtitle = "${method['address'].substring(0, 10)}...";
        break;
      default:
        icon = Icons.payment;
        subtitle = "";
    }
    
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      method['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8),
                    if (method['isPrimary'])
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Primary",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    SizedBox(width: 8),
                    if (method['isVerified'])
                      Icon(
                        Icons.verified,
                        color: Colors.green,
                        size: 16,
                      ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              // Handle menu item selection
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              if (!method['isPrimary'])
                PopupMenuItem(
                  value: 'primary',
                  child: Text('Set as Primary'),
                ),
              PopupMenuItem(
                value: 'delete',
                child: Text('Remove'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Transaction History",
              style: TextStyle(
                fontSize: 18,
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
            children: transactions.map((transaction) {
              return _buildTransactionItem(transaction);
            }).toList(),
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Center(
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.history, size: 16),
            label: Text("View All Transactions"),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    IconData icon;
    Color iconColor;
    String description;
    
    switch (transaction['type']) {
      case 'Deposit':
        icon = Icons.add_circle;
        iconColor = Colors.green;
        description = "Via ${transaction['method']}";
        break;
      case 'Withdrawal':
        icon = Icons.remove_circle;
        iconColor = Colors.red;
        description = "To ${transaction['method']}";
        break;
      case 'Investment':
        icon = Icons.attach_money;
        iconColor = Colors.blue;
        description = transaction['property'];
        break;
      case 'Dividend':
        icon = Icons.trending_up;
        iconColor = Colors.green;
        description = "From ${transaction['property']}";
        break;
      default:
        icon = Icons.swap_horiz;
        iconColor = Colors.grey;
        description = "";
    }
    
    final isPositive = transaction['amount'] > 0;
    final statusColor = transaction['status'] == 'Completed' ? Colors.green : Colors.orange;
    
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
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
                  transaction['type'],
                  style: TextStyle(
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
                "${isPositive ? '+' : ''}\$${transaction['amount'].abs()}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isPositive ? Colors.green : Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${transaction['status']} • ${_formatDate(transaction['date'])}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    final parts = dateStr.split('-');
    return '${parts[1]}/${parts[2]}/${parts[0]}';
  }

  void _showConfirmationDialog(String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: onConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }
}