// lib/presentation/pages/profile/widgets/account_info_section.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../domain/entities/user.dart';

class AccountInfoSection extends StatefulWidget {
  final User user;

  const AccountInfoSection({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _AccountInfoSectionState createState() => _AccountInfoSectionState();
}

class _AccountInfoSectionState extends State<AccountInfoSection> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _zipCodeController;
  late TextEditingController _countryController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber ?? '');
    _addressController = TextEditingController(text: '123 Main St');
    _cityController = TextEditingController(text: 'New York');
    _zipCodeController = TextEditingController(text: '10001');
    _countryController = TextEditingController(text: 'United States');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Personal Information",
              style: AppTextStyles.h4,
            ),
            _isEditing
                ? Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          _resetFields();
                          setState(() {
                            _isEditing = false;
                          });
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      SizedBox(width: AppDimensions.paddingS),
                      AppButton(
                        text: "Save",
                        onPressed: _saveChanges,
                        type: ButtonType.primary,
                      ),
                    ],
                  )
                : AppButton(
                    text: "Edit",
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    type: ButtonType.outline,
                    icon: Icons.edit,
                  ),
          ],
        ),
        SizedBox(height: AppDimensions.paddingL),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Info Section
              Text(
                "Basic Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: AppDimensions.paddingM),
              AppTextField(
                label: "Full Name",
                controller: _nameController,
                enabled: _isEditing,
                prefixIcon: Icons.person,
              ),
              SizedBox(height: AppDimensions.paddingM),
              AppTextField(
                label: "Email Address",
                controller: _emailController,
                enabled: false, // Email is typically not editable
                prefixIcon: Icons.email,
              ),
              SizedBox(height: AppDimensions.paddingM),
              AppTextField(
                label: "Phone Number",
                controller: _phoneController,
                enabled: _isEditing,
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              
              SizedBox(height: AppDimensions.paddingL),
              Divider(),
              SizedBox(height: AppDimensions.paddingL),
              
              // Address Section
              Text(
                "Address Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: AppDimensions.paddingM),
              AppTextField(
                label: "Street Address",
                controller: _addressController,
                enabled: _isEditing,
                prefixIcon: Icons.home,
              ),
              SizedBox(height: AppDimensions.paddingM),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: "City",
                      controller: _cityController,
                      enabled: _isEditing,
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingM),
                  Expanded(
                    child: AppTextField(
                      label: "Zip/Postal Code",
                      controller: _zipCodeController,
                      enabled: _isEditing,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.paddingM),
              AppTextField(
                label: "Country",
                controller: _countryController,
                enabled: _isEditing,
                prefixIcon: Icons.flag,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  void _resetFields() {
    _nameController.text = widget.user.name;
    _phoneController.text = widget.user.phoneNumber ?? '';
    _addressController.text = '123 Main St';
    _cityController.text = 'New York';
    _zipCodeController.text = '10001';
    _countryController.text = 'United States';
  }
  
  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // In a real app, you would submit changes to the backend here
      
      setState(() {
        _isEditing = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile information updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}