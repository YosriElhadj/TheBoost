// lib/presentation/pages/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../bloc/auth_controller.dart';
import '../base_page.dart';
import 'widgets/account_info_section.dart';
import 'widgets/investment_summary_section.dart';
import 'widgets/notification_settings_section.dart';
import 'widgets/security_settings_section.dart';
import 'widgets/verification_status_section.dart';
import 'widgets/wallet_section.dart';
import '../../../core/constants/dimensions.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    
    // Redirect to login if not authenticated
    if (!authController.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/auth');
      });
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final user = authController.currentUser!;

    return BasePage(
      title: 'My Profile',
      currentRoute: '/profile',
      body: Column(
        children: [
          _buildProfileHeader(context, user.name),
          
          // Tab bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: isMobile,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(text: "Account"),
                Tab(text: "Investments"),
                Tab(text: "Security"),
                Tab(text: "Notifications"),
                Tab(text: "Wallet"),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: Container(
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAccountTab(user, isMobile),
                  _buildInvestmentsTab(user, isMobile),
                  _buildSecurityTab(user, isMobile),
                  _buildNotificationsTab(user, isMobile),
                  _buildWalletTab(user, isMobile),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, String userName) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Container(
      width: double.infinity,
      color: AppColors.backgroundGreen,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
        vertical: AppDimensions.paddingXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Profile",
            style: AppTextStyles.h2,
          ),
          SizedBox(height: AppDimensions.paddingS),
          Text(
            "Manage your account settings and investment preferences",
            style: AppTextStyles.body2,
          ),
          SizedBox(height: AppDimensions.paddingL),
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primary,
                child: Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : "U",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: AppDimensions.paddingL),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingS,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "Verified Investor",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

  Widget _buildAccountTab(user, bool isMobile) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
        vertical: AppDimensions.paddingL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AccountInfoSection(user: user),
          SizedBox(height: AppDimensions.paddingXL),
          VerificationStatusSection(isVerified: true),
          SizedBox(height: AppDimensions.paddingXL),
          _buildDeactivateAccount(),
        ],
      ),
    );
  }

  Widget _buildInvestmentsTab(user, bool isMobile) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
        vertical: AppDimensions.paddingL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InvestmentSummarySection(),
        ],
      ),
    );
  }

  Widget _buildSecurityTab(user, bool isMobile) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
        vertical: AppDimensions.paddingL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SecuritySettingsSection(),
        ],
      ),
    );
  }

  Widget _buildNotificationsTab(user, bool isMobile) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
        vertical: AppDimensions.paddingL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationSettingsSection(),
        ],
      ),
    );
  }

  Widget _buildWalletTab(user, bool isMobile) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
        vertical: AppDimensions.paddingL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WalletSection(),
        ],
      ),
    );
  }

  Widget _buildDeactivateAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Deactivate Account",
          style: AppTextStyles.h4,
        ),
        SizedBox(height: AppDimensions.paddingM),
        Text(
          "Deactivating your account will remove your profile from TheBoost. You will need to contact customer support to restore your account.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
        SizedBox(height: AppDimensions.paddingL),
        AppButton(
          text: "Deactivate Account",
          onPressed: () {
            _showDeactivateDialog();
          },
          type: ButtonType.outline,
          isFullWidth: false,
        ),
      ],
    );
  }

  void _showDeactivateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Deactivate Account"),
        content: Text(
          "Are you sure you want to deactivate your account? This action will hide your profile and pause your investments. You can reactivate your account by contacting customer support.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account deactivation request submitted. Our team will contact you shortly.'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text("Deactivate"),
          ),
        ],
      ),
    );
  }
}