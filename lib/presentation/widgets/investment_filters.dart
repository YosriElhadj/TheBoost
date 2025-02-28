// presentation/pages/invest/widgets/investment_filters.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../bloc/property_controller.dart';

class InvestmentFilters extends StatelessWidget {
  final PropertyController controller;
  final bool isMobile;

  const InvestmentFilters({
    Key? key,
    required this.controller,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _buildMobileFilters(context);
    } else {
      return _buildDesktopFilters(context);
    }
  }

  Widget _buildMobileFilters(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filters",
                style: AppTextStyles.h4,
              ),
              TextButton(
                onPressed: () {
                  // Show full filter dialog
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => _buildFullFilterBottomSheet(context),
                  );
                },
                child: Text(
                  "More Filters",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingM),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                'All',
                'Urban Development',
                'Agricultural',
                'Commercial',
                'Residential',
                'Conservation',
                'Mixed-Use'
              ].map((category) {
                final isSelected = controller.selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () => controller.setCategory(category),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFilters(BuildContext context) {
    return Container(
      width: 280,
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filters",
              style: AppTextStyles.h4,
            ),
            SizedBox(height: AppDimensions.paddingL),
            
            // Category filter
            Text(
              "Property Category",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 12),
            _buildCategoryFilters(),
            SizedBox(height: 24),
            
            // Price range filter
            Text(
              "Investment Amount",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "\$${controller.priceRange.start.toInt()} - \$${controller.priceRange.end.toInt()}",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
            RangeSlider(
              values: controller.priceRange,
              min: 100,
              max: 50000,
              divisions: 499,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.backgroundGreen,
              labels: RangeLabels(
                "\$${controller.priceRange.start.toInt()}",
                "\$${controller.priceRange.end.toInt()}",
              ),
              onChanged: controller.setPriceRange,
            ),
            SizedBox(height: 24),
            
            // Return range filter
            Text(
              "Projected Annual Return",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${controller.returnRange.start.toInt()}% - ${controller.returnRange.end.toInt()}%",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
            RangeSlider(
              values: controller.returnRange,
              min: 5,
              max: 20,
              divisions: 15,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.backgroundGreen,
              labels: RangeLabels(
                "${controller.returnRange.start.toInt()}%",
                "${controller.returnRange.end.toInt()}%",
              ),
              onChanged: controller.setReturnRange,
            ),
            SizedBox(height: 24),
            
            // Risk level filter
            Text(
              "Risk Level",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 12),
            _buildRiskLevelCheckboxes(),
            SizedBox(height: 24),
            
            // Reset filters button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  controller.resetFilters();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Reset Filters",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        'All',
        'Urban Development',
        'Agricultural',
        'Commercial',
        'Residential',
        'Conservation',
        'Mixed-Use'
      ].map((category) {
        final isSelected = controller.selectedCategory == category;
        return InkWell(
          onTap: () => controller.setCategory(category),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRiskLevelCheckboxes() {
    return Column(
      children: [
        _buildCheckbox('Low Risk', controller.selectedRiskLevels.contains('Low')),
        SizedBox(height: 8),
        _buildCheckbox('Medium Risk', controller.selectedRiskLevels.contains('Medium')),
        SizedBox(height: 8),
        _buildCheckbox('Medium-High Risk', controller.selectedRiskLevels.contains('Medium-High')),
        SizedBox(height: 8),
        _buildCheckbox('High Risk', controller.selectedRiskLevels.contains('High')),
      ],
    );
  }

  Widget _buildCheckbox(String label, bool isChecked) {
    return InkWell(
      onTap: () {
        controller.toggleRiskLevel(label.split(' ')[0]);
      },
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: isChecked,
              onChanged: (value) {
                controller.toggleRiskLevel(label.split(' ')[0]);
              },
              activeColor: AppColors.primary,
            ),
          ),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullFilterBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filters",
                style: AppTextStyles.h3,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 24),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price range filter
                  Text(
                    "Investment Amount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "\$${controller.priceRange.start.toInt()} - \$${controller.priceRange.end.toInt()}",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                  RangeSlider(
                    values: controller.priceRange,
                    min: 100,
                    max: 50000,
                    divisions: 499,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.backgroundGreen,
                    labels: RangeLabels(
                      "\$${controller.priceRange.start.toInt()}",
                      "\$${controller.priceRange.end.toInt()}",
                    ),
                    onChanged: controller.setPriceRange,
                  ),
                  SizedBox(height: 24),
                  
                  // Return range filter
                  Text(
                    "Projected Annual Return",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${controller.returnRange.start.toInt()}% - ${controller.returnRange.end.toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                  RangeSlider(
                    values: controller.returnRange,
                    min: 5,
                    max: 20,
                    divisions: 15,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.backgroundGreen,
                    labels: RangeLabels(
                      "${controller.returnRange.start.toInt()}%",
                      "${controller.returnRange.end.toInt()}%",
                    ),
                    onChanged: controller.setReturnRange,
                  ),
                  SizedBox(height: 24),
                  
                  // Risk level filter
                  Text(
                    "Risk Level",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildRiskLevelCheckboxes(),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    controller.resetFilters();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Apply Filters",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}