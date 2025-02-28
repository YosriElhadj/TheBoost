// presentation/pages/auth/widgets/login_form.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/utils/input_validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../bloc/auth_controller.dart';

class LoginForm extends StatefulWidget {
  final Function updateView;
  final AuthController authController;

  LoginForm({
    required this.updateView,
    required this.authController,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // presentation/pages/auth/widgets/login_form.dart (continued)
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  "Log In",
                  style: AppTextStyles.h2,
                ),
              ),
              SizedBox(height: AppDimensions.paddingXL),
              
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
              SizedBox(height: AppDimensions.paddingS),
              
              // Forgot password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              // Error message
              if (widget.authController.status == AuthStatus.error)
                Container(
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
                          widget.authController.errorMessage ?? "Authentication failed",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: AppDimensions.paddingXL),
              
              // Login button
              AppButton(
                text: "Log In",
                onPressed: _handleLogin,
                isFullWidth: true,
                isLoading: widget.authController.status == AuthStatus.authenticating,
              ),
              SizedBox(height: AppDimensions.paddingL),
              
              // Sign up link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.updateView();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.paddingXL),
              
              // Social login
              Center(
                child: Text(
                  "Or log in with",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              SizedBox(height: AppDimensions.paddingL),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialButton(icon: Icons.g_mobiledata, onTap: () {}),
                  SizedBox(width: AppDimensions.paddingL),
                  _SocialButton(icon: Icons.facebook, onTap: () {}),
                  SizedBox(width: AppDimensions.paddingL),
                  _SocialButton(icon: Icons.apple, onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (widget.authController.status == AuthStatus.authenticating) {
      return;
    }

    // Reset any previous errors
    widget.authController.resetError();

    if (_formKey.currentState!.validate()) {
      final success = await widget.authController.login(
        _emailController.text,
        _passwordController.text,
      );

      if (success && mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
        ),
        child: Icon(
          icon,
          size: 30,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}