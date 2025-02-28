// presentation/widgets/steps_section.dart
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../core/constants/text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../core/widgets/section_title.dart';

class StepsSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<StepItem> steps;
  final bool useAlternateBackground;

  const StepsSection({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.steps,
    this.useAlternateBackground = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.paddingSection,
      ),
      color: useAlternateBackground ? AppColors.backgroundLight : Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
            ),
            child: Column(
              children: [
                SectionTitle(title: title),
                SizedBox(height: AppDimensions.paddingM),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body1,
                ),
                SizedBox(height: AppDimensions.paddingXXL),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
            ),
            child: isMobile
                ? Column(
                    children: steps.map((step) => _buildMobileStep(step)).toList(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: steps.map((step) => _buildDesktopStep(step)).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileStep(StepItem step) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimensions.paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: step.icon != null
                  ? Icon(step.icon, color: Colors.white, size: 32)
                  : Text(
                      step.number,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          SizedBox(height: AppDimensions.paddingL),
          Text(
            step.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.h4,
          ),
          SizedBox(height: AppDimensions.paddingS),
          Text(
            step.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.body3,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopStep(StepItem step) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: step.icon != null
                    ? Icon(step.icon, color: Colors.white, size: 32)
                    : Text(
                        step.number,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              step.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.h4,
            ),
            SizedBox(height: 12),
            Text(
              step.description,
              textAlign: TextAlign.center,
              style: AppTextStyles.body3,
            ),
          ],
        ),
      ),
    );
  }
}

class StepItem {
  final String number;
  final String title;
  final String description;
  final IconData? icon;

  StepItem({
    required this.number,
    required this.title,
    required this.description,
    this.icon,
  });
}