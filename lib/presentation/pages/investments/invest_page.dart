// presentation/pages/invest/invest_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../bloc/property_controller.dart';
import '../../widgets/investment_filters.dart';
import '../../widgets/investment_grid.dart';
import '../../widgets/investment_header.dart';
import '../base_page.dart';


class InvestPage extends StatefulWidget {
  @override
  _InvestPageState createState() => _InvestPageState();
}

class _InvestPageState extends State<InvestPage> {
  @override
  void initState() {
    super.initState();
    // Load properties when the page is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PropertyController>().loadProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final controller = Provider.of<PropertyController>(context);

    return BasePage(
      title: 'Investment Opportunities',
      currentRoute: '/invest',
      body: Column(
        children: [
          InvestmentHeader(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
              vertical: AppDimensions.paddingL,
            ),
            child: isMobile
                ? Column(
                    children: [
                      InvestmentFilters(
                        controller: controller,
                        isMobile: true,
                      ),
                      SizedBox(height: AppDimensions.paddingL),
                      _buildInvestmentContent(controller),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InvestmentFilters(
                        controller: controller,
                        isMobile: false,
                      ),
                      SizedBox(width: AppDimensions.paddingL),
                      Expanded(
                        child: _buildInvestmentContent(controller),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentContent(PropertyController controller) {
    if (controller.status == PropertyLoadingStatus.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (controller.status == PropertyLoadingStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              'Error loading properties',
              style: AppTextStyles.h3,
            ),
            SizedBox(height: 8),
            Text(
              controller.errorMessage ?? 'Unknown error',
              style: AppTextStyles.body2,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.loadProperties();
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInvestmentHeader(controller),
          SizedBox(height: AppDimensions.paddingM),
          InvestmentGrid(
            properties: controller.filteredProperties,
          ),
        ],
      );
    }
  }

  Widget _buildInvestmentHeader(PropertyController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${controller.filteredProperties.length} Investment Opportunities",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        DropdownButton<String>(
          value: 'Featured',
          onChanged: (String? value) {},
          items: ['Featured', 'Newest', 'Highest Return', 'Lowest Risk']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          underline: Container(
            height: 2,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}