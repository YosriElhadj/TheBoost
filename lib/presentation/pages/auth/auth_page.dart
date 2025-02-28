// presentation/pages/auth/auth_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../bloc/auth_controller.dart';
import '../../widgets/login_form.dart';
import '../../widgets/signup_form.dart';



class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with SingleTickerProviderStateMixin {
  bool isLogin = true;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _animationTextRotate = Tween<double>(
      begin: 0,
      end: 90,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void updateView() {
    setState(() {
      isLogin = !isLogin;
    });
    isLogin ? _animationController.reverse() : _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/auth_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
            ),
          ),
          child: Center(
            child: Container(
              width: isMobile ? size.width * 0.9 : size.width * 0.8,
              height: isMobile ? null : size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: isMobile
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLogo(),
                          Consumer<AuthController>(
                            builder: (context, authController, _) {
                              return AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: isLogin
                                    ? LoginForm(
                                        updateView: updateView,
                                        authController: authController,
                                      )
                                    : SignUpForm(
                                        updateView: updateView,
                                        authController: authController,
                                      ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppDimensions.radiusXXL),
                                bottomLeft: Radius.circular(AppDimensions.radiusXXL),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildLogo(isWhite: true),
                                SizedBox(height: 30),
                                Container(
                                  width: 280,
                                  child: AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      return Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(
                                            _animationTextRotate.value *
                                                (3.1415927 / 180)),
                                        child: Text(
                                          isLogin
                                              ? "Welcome back to TheBoost, where your land investment journey continues."
                                              : "Join TheBoost and start investing in tokenized land assets today.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 50),
                                _buildIllustration(),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Consumer<AuthController>(
                            builder: (context, authController, _) {
                              return AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: isLogin
                                    ? LoginForm(
                                        updateView: updateView,
                                        authController: authController,
                                      )
                                    : SignUpForm(
                                        updateView: updateView,
                                        authController: authController,
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo({bool isWhite = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.landscape,
          color: isWhite ? Colors.white : AppColors.primary,
          size: 40,
        ),
        SizedBox(width: 10),
        Text(
          'TheBoost',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isWhite ? Colors.white : AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildIllustration() {
    return Container(
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(
                    _animationTextRotate.value * (3.1415927 / 180)),
                child: Icon(
                  isLogin ? Icons.account_balance : Icons.token,
                  color: Colors.white,
                  size: 100,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}