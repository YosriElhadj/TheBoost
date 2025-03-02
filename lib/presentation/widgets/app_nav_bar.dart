// presentation/widgets/app_nav_bar.dart (updated)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../core/utils/responsive_helper.dart';
import '../../core/widgets/app_button.dart';
import '../bloc/auth_controller.dart';

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
    final authController = Provider.of<AuthController>(context);
    final isAuthenticated = authController.isAuthenticated;

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
          ? _buildMobileNavBar(context, isAuthenticated, authController)
          : _buildDesktopNavBar(context, isAuthenticated, authController),
    );
  }

  Widget _buildDesktopNavBar(BuildContext context, bool isAuthenticated, AuthController authController) {
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
            
            if (isAuthenticated) _buildUserMenu(context, authController)
            else Row(
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
        ),
      ],
    );
  }

  Widget _buildMobileNavBar(BuildContext context, bool isAuthenticated, AuthController authController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        Row(
          children: [
            if (isAuthenticated)
              IconButton(
                icon: Icon(Icons.dashboard),
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
              ),
              
            if (isAuthenticated)
              _buildUserMenuMobile(context, authController)
            else if (onLoginPressed != null)
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
    return InkWell(
      onTap: () {
        // Navigate to home
      },
      child: Row(
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
      ),
    );
  }

  Widget _buildUserMenu(BuildContext context, AuthController authController) {
    final user = authController.currentUser;
    final displayName = user?.name.split(' ')[0] ?? 'User';
    
    return PopupMenuButton<String>(
      offset: Offset(0, 40),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundGreen,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 16,
              child: Text(
                displayName.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: AppDimensions.paddingS),
            Text(
              displayName,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: AppDimensions.paddingS),
            Icon(
              Icons.arrow_drop_down,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'dashboard',
          child: Row(
            children: [
              Icon(Icons.dashboard, color: Colors.black54),
              SizedBox(width: AppDimensions.paddingM),
              Text('Dashboard'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person, color: Colors.black54),
              SizedBox(width: AppDimensions.paddingM),
              Text('My Profile'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'investments',
          child: Row(
            children: [
              Icon(Icons.token, color: Colors.black54),
              SizedBox(width: AppDimensions.paddingM),
              Text('My Investments'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings, color: Colors.black54),
              SizedBox(width: AppDimensions.paddingM),
              Text('Settings'),
            ],
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: AppDimensions.paddingM),
              Text('Logout', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'dashboard':
            Navigator.pushNamed(context, '/dashboard');
            break;
          case 'profile':
            Navigator.pushNamed(context, '/profile');
            break;
          case 'investments':
            // Navigate to investments page
            break;
          case 'settings':
            // Navigate to settings page
            break;
          case 'logout':
            authController.logout();
            Navigator.pushReplacementNamed(context, '/');
            break;
        }
      },
    );
  }

  Widget _buildUserMenuMobile(BuildContext context, AuthController authController) {
    return IconButton(
      icon: Icon(Icons.account_circle),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.dashboard, color: AppColors.primary),
                  title: Text('Dashboard'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person, color: AppColors.primary),
                  title: Text('My Profile'),
                  onTap: () {
                    Navigator.pop(context);
                        Navigator.pushNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.token, color: AppColors.primary),
                  title: Text('My Investments'),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to investments page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: AppColors.primary),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to settings page
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    authController.logout();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ],
            ),
          ),
        );
      },
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