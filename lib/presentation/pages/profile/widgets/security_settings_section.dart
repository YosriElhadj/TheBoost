// lib/presentation/pages/profile/widgets/security_settings_section.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/app_button.dart';

class SecuritySettingsSection extends StatefulWidget {
  @override
  _SecuritySettingsSectionState createState() => _SecuritySettingsSectionState();
}

class _SecuritySettingsSectionState extends State<SecuritySettingsSection> {
  final _passwordFormKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _twoFactorEnabled = true;
  bool _loginNotificationsEnabled = true;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Security Settings",
          style: AppTextStyles.h4,
        ),
        SizedBox(height: AppDimensions.paddingL),
        _buildSecurityOverview(),
        SizedBox(height: AppDimensions.paddingXL),
        _buildPasswordChange(),
        SizedBox(height: AppDimensions.paddingXL),
        _buildTwoFactorAuthentication(),
        SizedBox(height: AppDimensions.paddingXL),
        _buildLoginActivity(),
      ],
    );
  }

  Widget _buildSecurityOverview() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.security,
                color: AppColors.primary,
                size: 24,
              ),
              SizedBox(width: AppDimensions.paddingM),
              Text(
                "Security Status",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingM),
          _buildSecurityItem(
            "Password",
            "Last changed 30 days ago",
            Icons.lock,
            isCompleted: true,
          ),
          SizedBox(height: AppDimensions.paddingM),
          _buildSecurityItem(
            "Two-Factor Authentication",
            "Enabled",
            Icons.verified_user,
            isCompleted: true,
          ),
          SizedBox(height: AppDimensions.paddingM),
          _buildSecurityItem(
            "Email Verification",
            "Verified",
            Icons.email,
            isCompleted: true,
          ),
          SizedBox(height: AppDimensions.paddingM),
          _buildSecurityItem(
            "Phone Verification",
            "Verified",
            Icons.phone,
            isCompleted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityItem(String title, String status, IconData icon, {bool isCompleted = false}) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.primary : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: Colors.white,
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
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 2),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        isCompleted
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              )
            : AppButton(
                text: "Complete",
                onPressed: () {},
                type: ButtonType.primary,
              ),
      ],
    );
  }

  Widget _buildPasswordChange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Change Password",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Text(
          "Ensure your account is using a strong, secure password to protect your investments.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingL),
        Form(
          key: _passwordFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _currentPasswordController,
                obscureText: _obscureCurrentPassword,
                decoration: InputDecoration(
                  labelText: "Current Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureCurrentPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppDimensions.paddingM),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  labelText: "New Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppDimensions.paddingM),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm New Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppDimensions.paddingL),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    text: "Change Password",
                    onPressed: _changePassword,
                    type: ButtonType.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTwoFactorAuthentication() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Two-Factor Authentication",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Text(
          "Add an extra layer of security to your account by requiring both your password and a verification code.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingL),
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingL),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: _twoFactorEnabled ? AppColors.primary : Colors.grey,
                      ),
                      SizedBox(width: AppDimensions.paddingM),
                      Text(
                        "Enable Two-Factor Authentication",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: _twoFactorEnabled,
                    onChanged: (value) {
                      setState(() {
                        _twoFactorEnabled = value;
                      });
                      if (value) {
                        _showTwoFactorSetupDialog();
                      }
                    },
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
              if (_twoFactorEnabled) ...[
                SizedBox(height: AppDimensions.paddingM),
                Divider(),
                SizedBox(height: AppDimensions.paddingM),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                      size: 20,
                    ),
                    SizedBox(width: AppDimensions.paddingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Two-factor authentication is enabled",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "You'll be asked to enter a verification code from your authenticator app when signing in.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: AppDimensions.paddingM),
                          Row(
                            children: [
                              AppButton(
                                text: "Change Method",
                                onPressed: () {},
                                type: ButtonType.outline,
                              ),
                              SizedBox(width: AppDimensions.paddingM),
                              AppButton(
                                text: "View Recovery Codes",
                                onPressed: () {},
                                type: ButtonType.outline,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Login Activity",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Text(
          "Review your recent login activity and manage login notifications.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: AppDimensions.paddingL),
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingL),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: _loginNotificationsEnabled ? AppColors.primary : Colors.grey,
                      ),
                      SizedBox(width: AppDimensions.paddingM),
                      Text(
                        "Login Notifications",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: _loginNotificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _loginNotificationsEnabled = value;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.paddingM),
              Text(
                "Receive email notifications when someone logs into your account from a new device or location",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: AppDimensions.paddingL),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Login Activity",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("View All"),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.paddingM),
              _buildLoginActivityItem(
                date: "Feb 28, 2025",
                device: "Chrome on Windows",
                location: "New York, USA",
                ip: "192.168.1.1",
                isCurrentDevice: true,
              ),
              SizedBox(height: AppDimensions.paddingM),
              _buildLoginActivityItem(
                date: "Feb 25, 2025",
                device: "TheBoost App on iPhone",
                location: "New York, USA",
                ip: "192.168.1.2",
                isCurrentDevice: false,
              ),
              SizedBox(height: AppDimensions.paddingM),
              _buildLoginActivityItem(
                date: "Feb 20, 2025",
                device: "Safari on MacBook",
                location: "Boston, USA",
                ip: "192.168.1.3",
                isCurrentDevice: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginActivityItem({
    required String date,
    required String device,
    required String location,
    required String ip,
    required bool isCurrentDevice,
  }) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: isCurrentDevice ? AppColors.backgroundGreen : Colors.grey[100],
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Row(
        children: [
          Icon(
            Icons.devices,
            color: isCurrentDevice ? AppColors.primary : Colors.grey,
          ),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      device,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "$location • IP: $ip${isCurrentDevice ? ' (Current Device)' : ''}",
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

  void _changePassword() {
    if (_passwordFormKey.currentState!.validate()) {
      // In a real app, you would submit changes to the backend here
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password changed successfully'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Clear form
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    }
  }

  void _showTwoFactorSetupDialog() {
    // In a real app, this would show a QR code for the user to scan with their authenticator app
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Set Up Two-Factor Authentication"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Scan the QR code with your authenticator app (Google Authenticator, Authy, etc.).",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: AppDimensions.paddingL),
            Container(
              width: 200,
              height: 200,
              color: Colors.grey[300],
              child: Center(
                child: Text(
                  "QR Code Placeholder",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingL),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Verification Code",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _twoFactorEnabled = false;
              });
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Two-factor authentication enabled successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text("Verify"),
          ),
        ],
      ),
    );
  }
}