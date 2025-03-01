// lib/presentation/pages/profile/widgets/verification_status_section.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/app_button.dart';

class VerificationStatusSection extends StatelessWidget {
  final bool isVerified;

  const VerificationStatusSection({
    Key? key,
    required this.isVerified,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verification Status",
          style: AppTextStyles.h4,
        ),
        SizedBox(height: AppDimensions.paddingM),
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingL),
          decoration: BoxDecoration(
            color: isVerified ? AppColors.backgroundGreen : Colors.orange.shade50,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isVerified ? Colors.green : Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        isVerified ? Icons.verified_user : Icons.pending,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isVerified ? "Fully Verified" : "Verification Pending",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          isVerified
                              ? "Your account is fully verified. You have access to all investment opportunities."
                              : "We're reviewing your verification documents. This usually takes 1-2 business days.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isVerified) ...[
                SizedBox(height: AppDimensions.paddingL),
                _buildVerificationItem(
                  title: "Identity Verification",
                  status: "Completed",
                  date: "Jan 15, 2025",
                  isCompleted: true,
                ),
                SizedBox(height: AppDimensions.paddingM),
                _buildVerificationItem(
                  title: "Address Verification",
                  status: "Completed",
                  date: "Jan 15, 2025",
                  isCompleted: true,
                ),
                SizedBox(height: AppDimensions.paddingM),
                _buildVerificationItem(
                  title: "Financial Information",
                  status: "Completed",
                  date: "Jan 16, 2025",
                  isCompleted: true,
                ),
                SizedBox(height: AppDimensions.paddingM),
                _buildVerificationItem(
                  title: "Accredited Investor Status",
                  status: "Completed",
                  date: "Jan 17, 2025",
                  isCompleted: true,
                ),
              ] else ...[
                SizedBox(height: AppDimensions.paddingL),
                _buildVerificationItem(
                  title: "Identity Verification",
                  status: "Completed",
                  date: "Jan 15, 2025",
                  isCompleted: true,
                ),
                SizedBox(height: AppDimensions.paddingM),
                _buildVerificationItem(
                  title: "Address Verification",
                  status: "Completed",
                  date: "Jan 15, 2025",
                  isCompleted: true,
                ),
                SizedBox(height: AppDimensions.paddingM),
                _buildVerificationItem(
                  title: "Financial Information",
                  status: "In Progress",
                  date: null,
                  isCompleted: false,
                ),
                SizedBox(height: AppDimensions.paddingM),
                _buildVerificationItem(
                  title: "Accredited Investor Status",
                  status: "Pending",
                  date: null,
                  isCompleted: false,
                ),
                SizedBox(height: AppDimensions.paddingL),
                AppButton(
                  text: "Complete Verification",
                  onPressed: () {},
                  type: ButtonType.primary,
                  icon: Icons.verified_user,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationItem({
    required String title,
    required String status,
    required bool isCompleted,
    String? date,
  }) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green : Colors.grey.shade400,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              isCompleted ? Icons.check : Icons.hourglass_empty,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
        SizedBox(width: AppDimensions.paddingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                isCompleted ? "Completed on $date" : status,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Text(
          status,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isCompleted ? Colors.green : Colors.orange,
          ),
        ),
      ],
    );
  }
}