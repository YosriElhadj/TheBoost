// presentation/pages/dashboard/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/section_title.dart';
import '../../bloc/auth_controller.dart';
import '../../bloc/property_controller.dart';
import '../base_page.dart';
import 'widgets/dashboard_stats.dart';
import 'widgets/investment_portfolio.dart';
import 'widgets/recent_activity.dart';
import 'widgets/featured_properties.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Load data when the page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PropertyController>().loadProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final propertyController = Provider.of<PropertyController>(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    
    // Redirect to login if not authenticated
    if (!authController.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/auth');
      });
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BasePage(
      title: 'Dashboard',
      currentRoute: '/dashboard',
      body: Column(
        children: [
          _buildDashboardHeader(context, authController),
          SizedBox(height: AppDimensions.paddingL),
          
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardStats(),
                SizedBox(height: AppDimensions.paddingXL),
                
                SectionTitle(title: "Your Portfolio"),
                SizedBox(height: AppDimensions.paddingL),
                InvestmentPortfolio(),
                SizedBox(height: AppDimensions.paddingXL),
                
                SectionTitle(title: "Recent Activity"),
                SizedBox(height: AppDimensions.paddingL),
                RecentActivity(),
                SizedBox(height: AppDimensions.paddingXL),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SectionTitle(title: "Featured Properties"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/invest');
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppDimensions.paddingL),
                FeaturedProperties(
                  properties: propertyController.properties
                      .where((property) => property.isFeatured)
                      .take(3)
                      .toList(),
                ),
                SizedBox(height: AppDimensions.paddingXXL),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardHeader(BuildContext context, AuthController authController) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
        vertical: AppDimensions.paddingXL,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome back, ${authController.currentUser?.name.split(' ')[0] ?? 'Investor'}!",
            style: AppTextStyles.h2.copyWith(
              fontSize: isMobile ? 24 : 32,
            ),
          ),
          SizedBox(height: AppDimensions.paddingS),
          Text(
            "Here's a summary of your investment portfolio",
            style: AppTextStyles.body2,
          ),
          SizedBox(height: AppDimensions.paddingL),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(
                text: "Discover Properties",
                onPressed: () {
                  Navigator.pushNamed(context, '/invest');
                },
                type: ButtonType.primary,
                icon: Icons.search,
              ),
            ],
          ),
        ],
      ),
    );
  }
}