// main.dart (updated)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/constants/colors.dart';
import 'presentation/bloc/auth_controller.dart';
import 'presentation/bloc/property_controller.dart';
import 'presentation/bloc/routes.dart';
import 'presentation/bloc/service_locator.dart';


void main() {
  setupServiceLocator();
  runApp(TheBoostApp());
}

class TheBoostApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<AuthController>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<PropertyController>(),
        ),
      ],
      child: MaterialApp(
        title: 'TheBoost - Land Investment via Tokenization',
        theme: ThemeData(
          primaryColor: AppColors.primary,
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            secondary: AppColors.primaryLight,
            surface: Colors.white,
            background: Colors.white,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
        builder: (context, child) {
          return Consumer<AuthController>(
            builder: (context, authController, _) {
              // Redirect to dashboard if logged in and trying to access auth page
              if (child?.key == ValueKey('AuthPage') && authController.isAuthenticated) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
                });
              }
              
              return child!;
            },
          );
        },
      ),
    );
  }
}