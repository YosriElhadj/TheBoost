// presentation/pages/dashboard/widgets/featured_properties.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../domain/entities/property.dart';

class FeaturedProperties extends StatelessWidget {
  final List<Property> properties;

  const FeaturedProperties({
    Key? key,
    required this.properties,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return properties.isEmpty
        ? Center(
            child: Text(
              "No featured properties available",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          )
        : isMobile
            ? Column(
                children: properties.map((property) => _buildPropertyCard(context, property)).toList(),
              )
            : Row(
                children: properties.map((property) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
                      child: _buildPropertyCard(context, property),
                    ),
                  );
                }).toList(),
              );
  }

  Widget _buildPropertyCard(BuildContext context, Property property) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property image
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDimensions.radiusM),
              ),
              image: property.imageUrl.isNotEmpty
                  ? DecorationImage(
                      image: AssetImage(property.imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: property.imageUrl.isEmpty
                ? Center(
                    child: Icon(
                      Icons.image,
                      color: Colors.grey[400],
                      size: 48,
                    ),
                  )
                : null,
          ),
          
          // Property details
          Padding(
            padding: EdgeInsets.all(AppDimensions.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingS,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundGreen,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    property.category,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: AppDimensions.paddingS),
                Text(
                  property.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  property.location,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingM),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Min Investment",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "\$${property.minInvestment.toInt()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Expected Return",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "${property.projectedReturn}%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: AppDimensions.paddingL),
                AppButton(
                  text: "Invest Now",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/property-details',
                      arguments: property.id,
                    );
                  },
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}