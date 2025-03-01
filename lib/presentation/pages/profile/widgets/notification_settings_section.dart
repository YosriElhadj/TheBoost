// lib/presentation/pages/profile/widgets/notification_settings_section.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/app_button.dart';

class NotificationSettingsSection extends StatefulWidget {
  @override
  _NotificationSettingsSectionState createState() => _NotificationSettingsSectionState();
}

class _NotificationSettingsSectionState extends State<NotificationSettingsSection> {
  // Email notifications
  bool _emailNewInvestments = true;
  bool _emailPortfolioUpdates = true;
  bool _emailTransactions = true;
  bool _emailMarketUpdates = false;
  bool _emailPromotions = false;
  
  // Push notifications
  bool _pushNewInvestments = true;
  bool _pushPortfolioUpdates = true;
  bool _pushTransactions = true;
  bool _pushMarketUpdates = true;
  bool _pushPromotions = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Notification Settings",
          style: AppTextStyles.h4,
        ),
        SizedBox(height: AppDimensions.paddingM),
        Text(
          "Manage how you receive updates about your investments and account activity.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingL),
        _buildEmailNotifications(),
        SizedBox(height: AppDimensions.paddingXL),
        _buildPushNotifications(),
        SizedBox(height: AppDimensions.paddingXL),
        _buildNotificationSchedule(),
      ],
    );
  }

  Widget _buildEmailNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email Notifications",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              _buildNotificationToggle(
                "New Investment Opportunities",
                "Be notified when new properties become available",
                _emailNewInvestments,
                (value) {
                  setState(() {
                    _emailNewInvestments = value;
                  });
                },
              ),
              _buildDivider(),
              _buildNotificationToggle(
                "Portfolio Updates",
                "Weekly summary of your portfolio performance",
                _emailPortfolioUpdates,
                (value) {
                  setState(() {
                    _emailPortfolioUpdates = value;
                  });
                },
              ),
              _buildDivider(),
              _buildNotificationToggle(
                "Transaction Confirmations",
                "Receive confirmation for all investments and withdrawals",
                _emailTransactions,
                (value) {
                  setState(() {
                    _emailTransactions = value;
                  });
                },
              ),
              _buildDivider(),
              _buildNotificationToggle(
                "Market Updates",
                "Insights and news about the real estate market",
                _emailMarketUpdates,
                (value) {
                  setState(() {
                    _emailMarketUpdates = value;
                  });
                },
              ),
              _buildDivider(),
              _buildNotificationToggle(
                "Promotions & Offers",
                "Special offers, promotions, and investment opportunities",
                _emailPromotions,
                (value) {
                  setState(() {
                    _emailPromotions = value;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPushNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Push Notifications",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              _buildNotificationToggle(
                "New Investment Opportunities",
                "Be notified when new properties become available",
                _pushNewInvestments,
                (value) {
                  setState(() {
                    _pushNewInvestments = value;
                  });
                },
              ),
              _buildDivider(),
              _buildNotificationToggle(
                "Portfolio Updates",
                "Daily summary of your portfolio performance",
                _pushPortfolioUpdates,
                (value) {
                  setState(() {
                    _pushPortfolioUpdates = value;
                  });
                },
              ),
              _buildDivider(),
              _buildNotificationToggle(
                "Transaction Confirmations",
                "Receive confirmation for all investments and withdrawals",
                _pushTransactions,
                (value) {
                  setState(() {
                    _pushTransactions = value;
                  });
                },
              ),
              _buildDivider(),
              _buildNotificationToggle(
                "Market Updates",
                "Insights and news about the real estate market",
                _pushMarketUpdates,
                (value) {
                  setState(() {
                    _pushMarketUpdates = value;
                  });
                },
              ),
              _buildDivider(),
              _buildNotificationToggle(
                "Promotions & Offers",
                "Special offers, promotions, and investment opportunities",
                _pushPromotions,
                (value) {
                  setState(() {
                    _pushPromotions = value;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Notification Schedule",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Set your preferred notification schedule to avoid disturbances during certain hours.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: AppDimensions.paddingL),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quiet Hours Start",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
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
                            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                          ),
                          child: DropdownButton<String>(
                            value: "10:00 PM",
                            isExpanded: true,
                            underline: SizedBox(),
                            items: [
                              "8:00 PM",
                              "9:00 PM",
                              "10:00 PM",
                              "11:00 PM",
                              "12:00 AM",
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingL),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quiet Hours End",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
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
                            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                          ),
                          child: DropdownButton<String>(
                            value: "7:00 AM",
                            isExpanded: true,
                            underline: SizedBox(),
                            items: [
                              "6:00 AM",
                              "7:00 AM",
                              "8:00 AM",
                              "9:00 AM",
                              "10:00 AM",
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.paddingL),
              Row(
                children: [
                  Text(
                    "Time Zone:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingM),
                  Text(
                    "Eastern Time (ET)",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingS),
                  TextButton(
                    onPressed: () {},
                    child: Text("Change"),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.paddingL),
              AppButton(
                text: "Save Schedule",
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Notification schedule updated successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                type: ButtonType.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationToggle(
    String title,
    String description,
    bool value,
    Function(bool) onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Row(
        children: [
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
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade200,
    );
  }
}