// presentation/pages/auth/widgets/signup_form.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/utils/input_validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../bloc/auth_controller.dart';

class SignUpForm extends StatefulWidget {
  final Function updateView;
  final AuthController authController;

  SignUpForm({
    required this.updateView,
    required this.authController,
  });

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingXL),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MediaQuery.of(context).size.width < 768
                  ? SizedBox(height: AppDimensions.paddingL)
                  : SizedBox(height: 0),
              Center(
                child: Text(
                  "Create Account",
                  style: AppTextStyles.h2,
                ),
              ),
              SizedBox(height: AppDimensions.paddingXL),
              
              // Name field
              AppTextField(
                label: "Full Name",
                prefixIcon: Icons.person_outline,
                validator: InputValidators.validateName,
                controller: _nameController,
              ),
              SizedBox(height: AppDimensions.paddingL),
              
              // Email field
              AppTextField(
                label: "Email",
                prefixIcon: Icons.email_outlined,
                validator: InputValidators.validateEmail,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              SizedBox(height: AppDimensions.paddingL),
              
              // Password field
              AppTextField(
                label: "Password",
                prefixIcon: Icons.lock_outline,
                obscureText: obscurePassword,
                validator: InputValidators.validatePassword,
                controller: _passwordController,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  icon: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.paddingL),
              
              // Confirm password field
              AppTextField(
                label: "Confirm Password",
                prefixIcon: Icons.lock_outline,
                obscureText: obscureConfirmPassword,
                validator: (value) => InputValidators.validateConfirmPassword(
                  value,
                  _passwordController.text,
                ),
                controller: _confirmPasswordController,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                  icon: Icon(
                    obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.paddingL),
              
              // Terms and conditions
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value ?? false;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  Expanded(
                    child: Text(
                      "I agree to the Terms of Service and Privacy Policy",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              
              // Error message
              if (widget.authController.status == AuthStatus.error)
                Container(
                  margin: EdgeInsets.only(top: AppDimensions.paddingM),
                  padding: EdgeInsets.all(AppDimensions.paddingM),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red),
                      SizedBox(width: AppDimensions.paddingS),
                      Expanded(
                        child: Text(
                          widget.authController.errorMessage ?? "Registration failed",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: AppDimensions.paddingXL),
              
              // Sign up button
              AppButton(
                text: "Sign Up",
                onPressed: _handleSignUp,
                isFullWidth: true,
                isLoading: widget.authController.status == AuthStatus.authenticating,
              ),
              SizedBox(height: AppDimensions.paddingL),
              
              // Login link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.updateView();
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignUp() async {
    if (widget.authController.status == AuthStatus.authenticating) {
      return;
    }

    // Reset any previous errors
    widget.authController.resetError();

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please accept the Terms of Service and Privacy Policy'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final success = await widget.authController.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );

      if (success && mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }
}