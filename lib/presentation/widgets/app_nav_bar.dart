import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../core/utils/responsive_helper.dart';
import '../../core/widgets/app_button.dart';

class AppNavBar extends StatelessWidget {
  final VoidCallback? onLoginPressed;
  final VoidCallback? onSignUpPressed;
  final String? currentRoute;

  const AppNavBar({
    Key? key,
    this.onLoginPressed,
    this.onSignUpPressed,
    this.currentRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
        vertical: AppDimensions.paddingM,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: isMobile
          ? _buildMobileNavBar(context)
          : _buildDesktopNavBar(context),
    );
  }

  Widget _buildDesktopNavBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        Row(
          children: [
            _NavLink('Home', route: '/', currentRoute: currentRoute),
            _NavLink('Features', route: '/features', currentRoute: currentRoute),
            _NavLink('How It Works', route: '/how-it-works', currentRoute: currentRoute),
            _NavLink('Invest', route: '/invest', currentRoute: currentRoute),
            _NavLink('Learn More', route: '/learn-more', currentRoute: currentRoute),
            SizedBox(width: AppDimensions.paddingM),
            if (onLoginPressed != null)
              TextButton(
                onPressed: onLoginPressed,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            SizedBox(width: AppDimensions.paddingS),
            if (onSignUpPressed != null)
              AppButton(
                text: 'Get Started',
                onPressed: onSignUpPressed ?? () {},
                type: ButtonType.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL,
                  vertical: AppDimensions.paddingS,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNavBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        Row(
          children: [
            if (onLoginPressed != null)
              TextButton(
                onPressed: onLoginPressed,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Icon(Icons.landscape, color: AppColors.primary, size: 32),
        SizedBox(width: 8),
        Text(
          'TheBoost',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  final String title;
  final String route;
  final String? currentRoute;
  
  _NavLink(this.title, {required this.route, this.currentRoute});
  
  @override
  Widget build(BuildContext context) {
    final bool isActive = currentRoute == route;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: TextButton(
        onPressed: () {
          if (!isActive) {
            Navigator.of(context).pushNamed(route);
          }
        },
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}