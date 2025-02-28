// presentation/pages/property_details/property_details_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../domain/entities/property.dart';
import '../../bloc/auth_controller.dart';
import '../../bloc/property_controller.dart';
import '../base_page.dart';
import 'widgets/property_details_header.dart';
import 'widgets/property_information.dart';
import 'widgets/investment_calculator.dart';
import 'widgets/property_gallery.dart';
import 'widgets/similar_properties.dart';

class PropertyDetailsPage extends StatefulWidget {
  final String propertyId;

  const PropertyDetailsPage({
    Key? key,
    required this.propertyId,
  }) : super(key: key);

  @override
  _PropertyDetailsPageState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  late Property property;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeProperty();
    });
  }

  Future<void> _initializeProperty() async {
    final propertyController = Provider.of<PropertyController>(context, listen: false);
    
    try {
      if (propertyController.properties.isEmpty) {
        await propertyController.loadProperties();
      }
      
      property = propertyController.properties.firstWhere(
        (p) => p.id == widget.propertyId,
      );
      
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      // Handle error - property not found
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Property not found'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final authController = Provider.of<AuthController>(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return BasePage(
      title: property.title,
      currentRoute: '/property-details',
      body: Column(
        children: [
          PropertyDetailsHeader(property: property),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppDimensions.paddingL : AppDimensions.paddingXXL,
              vertical: AppDimensions.paddingXL,
            ),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PropertyInformation(property: property),
                      SizedBox(height: AppDimensions.paddingXL),
                      InvestmentCalculator(
                        property: property,
                        isAuthenticated: authController.isAuthenticated,
                      ),
                      SizedBox(height: AppDimensions.paddingXL),
                      PropertyGallery(property: property),
                      SizedBox(height: AppDimensions.paddingXL),
                      SimilarProperties(
                        currentPropertyId: property.id,
                        category: property.category,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: PropertyInformation(property: property),
                          ),
                          SizedBox(width: AppDimensions.paddingXL),
                          Expanded(
                            flex: 3,
                            child: InvestmentCalculator(
                              property: property,
                              isAuthenticated: authController.isAuthenticated,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimensions.paddingXXL),
                      PropertyGallery(property: property),
                      SizedBox(height: AppDimensions.paddingXXL),
                      SimilarProperties(
                        currentPropertyId: property.id,
                        category: property.category,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}