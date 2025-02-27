import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import this from your landing page file
// import 'landing_page.dart' show FooterSection;

class InvestingPage extends StatefulWidget {
  @override
  _InvestingPageState createState() => _InvestingPageState();
}

class _InvestingPageState extends State<InvestingPage> {
  // Filter states
  String _selectedCategory = 'All';
  RangeValues _priceRange = RangeValues(100, 50000);
  RangeValues _returnRange = RangeValues(5, 20);
  
  // Sample investment opportunities
  final List<Map<String, dynamic>> _investments = [
    {
      'title': 'Urban Development Land - Downtown Metro',
      'location': 'Phoenix, Arizona',
      'category': 'Urban Development',
      'minInvestment': 500,
      'tokenPrice': 50,
      'totalValue': 2500000,
      'projectedReturn': 12.5,
      'riskLevel': 'Medium',
      'availableTokens': 18500,
      'fundingPercentage': 0.78,
      'image': 'assets/property1.jpg',
      'featured': true,
    },
    {
      'title': 'Agricultural Farmland - Riverside County',
      'location': 'Riverside, California',
      'category': 'Agricultural',
      'minInvestment': 100,
      'tokenPrice': 10,
      'totalValue': 1200000,
      'projectedReturn': 7.8,
      'riskLevel': 'Low',
      'availableTokens': 42000,
      'fundingPercentage': 0.65,
      'image': 'assets/property2.jpg',
      'featured': false,
    },
    {
      'title': 'Commercial District - Tech Corridor',
      'location': 'Austin, Texas',
      'category': 'Commercial',
      'minInvestment': 1000,
      'tokenPrice': 100,
      'totalValue': 5800000,
      'projectedReturn': 15.2,
      'riskLevel': 'Medium-High',
      'availableTokens': 15000,
      'fundingPercentage': 0.82,
      'image': 'assets/property3.jpg',
      'featured': true,
    },
    {
      'title': 'Eco-Conservation Land - Mountain Reserve',
      'location': 'Boulder, Colorado',
      'category': 'Conservation',
      'minInvestment': 250,
      'tokenPrice': 25,
      'totalValue': 1800000,
      'projectedReturn': 6.5,
      'riskLevel': 'Low',
      'availableTokens': 28000,
      'fundingPercentage': 0.45,
      'image': 'assets/property4.jpg',
      'featured': false,
    },
    {
      'title': 'Residential Development - Lakeside Community',
      'location': 'Nashville, Tennessee',
      'category': 'Residential',
      'minInvestment': 750,
      'tokenPrice': 75,
      'totalValue': 3200000,
      'projectedReturn': 10.8,
      'riskLevel': 'Medium',
      'availableTokens': 22000,
      'fundingPercentage': 0.71,
      'image': 'assets/property5.jpg',
      'featured': false,
    },
    {
      'title': 'Mixed-Use Development - Harbor District',
      'location': 'Seattle, Washington',
      'category': 'Mixed-Use',
      'minInvestment': 1500,
      'tokenPrice': 150,
      'totalValue': 7500000,
      'projectedReturn': 14.5,
      'riskLevel': 'Medium-High',
      'availableTokens': 10000,
      'fundingPercentage': 0.88,
      'image': 'assets/property6.jpg',
      'featured': true,
    },
  ];

  // Filtered investments
  List<Map<String, dynamic>> get _filteredInvestments {
    return _investments.where((investment) {
      // Filter by category
      if (_selectedCategory != 'All' && investment['category'] != _selectedCategory) {
        return false;
      }
      
      // Filter by price range
      if (investment['minInvestment'] < _priceRange.start || 
          investment['minInvestment'] > _priceRange.end) {
        return false;
      }
      
      // Filter by return range
      if (investment['projectedReturn'] < _returnRange.start || 
          investment['projectedReturn'] > _returnRange.end) {
        return false;
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF2E7D32)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Icon(Icons.landscape, color: Color(0xFF2E7D32), size: 24),
            SizedBox(width: 8),
            Text(
              'TheBoost',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.black87),
            onPressed: () {},
          ),
          SizedBox(width: 16),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              _InvestmentPageHeader(),
              Expanded(
                child: isMobile
                    ? Column(
                        children: [
                          _MobileFilters(
                            selectedCategory: _selectedCategory,
                            priceRange: _priceRange,
                            returnRange: _returnRange,
                            onCategoryChanged: (String category) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            onPriceRangeChanged: (RangeValues values) {
                              setState(() {
                                _priceRange = values;
                              });
                            },
                            onReturnRangeChanged: (RangeValues values) {
                              setState(() {
                                _returnRange = values;
                              });
                            },
                          ),
                          Expanded(
                            child: _InvestmentGridView(
                              investments: _filteredInvestments,
                              constraints: constraints,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SidebarFilters(
                            selectedCategory: _selectedCategory,
                            priceRange: _priceRange,
                            returnRange: _returnRange,
                            onCategoryChanged: (String category) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            onPriceRangeChanged: (RangeValues values) {
                              setState(() {
                                _priceRange = values;
                              });
                            },
                            onReturnRangeChanged: (RangeValues values) {
                              setState(() {
                                _returnRange = values;
                              });
                            },
                          ),
                          Expanded(
                            child: _InvestmentGridView(
                              investments: _filteredInvestments,
                              constraints: constraints,
                            ),
                          ),
                        ],
                      ),
              ),
              // Use the FooterSection from the landing page
              // FooterSection(),
              
              // For now, we'll use a simplified footer
              _SimpleFooter(),
            ],
          );
        },
      ),
    );
  }
}

class _InvestmentPageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 30 : 50,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFE8F5E9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Investment Opportunities",
            style: GoogleFonts.montserrat(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Discover and invest in premium tokenized land assets",
            style: TextStyle(
              fontSize: isMobile ? 14 : 18,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 20),
          if (isMobile)
            Column(
              children: [
                _StatCard(
                  value: '26',
                  label: 'Available Properties',
                  icon: Icons.location_on,
                ),
                SizedBox(height: 10),
                _StatCard(
                  value: '\$100',
                  label: 'Minimum Investment',
                  icon: Icons.attach_money,
                ),
                SizedBox(height: 10),
                _StatCard(
                  value: '8.4%',
                  label: 'Avg. Annual Return',
                  icon: Icons.trending_up,
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    value: '26',
                    label: 'Available Properties',
                    icon: Icons.location_on,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    value: '\$100',
                    label: 'Minimum Investment',
                    icon: Icons.attach_money,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    value: '8.4%',
                    label: 'Avg. Annual Return',
                    icon: Icons.trending_up,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Color(0xFF2E7D32),
              size: isMobile ? 18 : 24,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: isMobile ? 10 : 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SidebarFilters extends StatelessWidget {
  final String selectedCategory;
  final RangeValues priceRange;
  final RangeValues returnRange;
  final Function(String) onCategoryChanged;
  final Function(RangeValues) onPriceRangeChanged;
  final Function(RangeValues) onReturnRangeChanged;

  const _SidebarFilters({
    required this.selectedCategory,
    required this.priceRange,
    required this.returnRange,
    required this.onCategoryChanged,
    required this.onPriceRangeChanged,
    required this.onReturnRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: double.infinity,
      padding: EdgeInsets.all(24),
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filters",
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),
            
            // Category filter
            Text(
              "Property Category",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            _buildCategoryFilters(),
            SizedBox(height: 24),
            
            // Price range filter
            Text(
              "Investment Amount",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "\$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF2E7D32),
              ),
            ),
            RangeSlider(
              values: priceRange,
              min: 100,
              max: 50000,
              divisions: 499,
              activeColor: Color(0xFF2E7D32),
              inactiveColor: Color(0xFFE8F5E9),
              labels: RangeLabels(
                "\$${priceRange.start.toInt()}",
                "\$${priceRange.end.toInt()}",
              ),
              onChanged: onPriceRangeChanged,
            ),
            SizedBox(height: 24),
            
            // Return range filter
            Text(
              "Projected Annual Return",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${returnRange.start.toInt()}% - ${returnRange.end.toInt()}%",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF2E7D32),
              ),
            ),
            RangeSlider(
              values: returnRange,
              min: 5,
              max: 20,
              divisions: 15,
              activeColor: Color(0xFF2E7D32),
              inactiveColor: Color(0xFFE8F5E9),
              labels: RangeLabels(
                "${returnRange.start.toInt()}%",
                "${returnRange.end.toInt()}%",
              ),
              onChanged: onReturnRangeChanged,
            ),
            SizedBox(height: 24),
            
            // Risk level filter
            Text(
              "Risk Level",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            _buildRiskLevelCheckboxes(),
            SizedBox(height: 24),
            
            // Reset filters button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  onCategoryChanged('All');
                  onPriceRangeChanged(RangeValues(100, 50000));
                  onReturnRangeChanged(RangeValues(5, 20));
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFF2E7D32)),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Reset Filters",
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    final categories = [
      'All',
      'Urban Development',
      'Agricultural',
      'Commercial',
      'Residential',
      'Conservation',
      'Mixed-Use'
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        final isSelected = selectedCategory == category;
        return InkWell(
          onTap: () => onCategoryChanged(category),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFF2E7D32) : Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.black54,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRiskLevelCheckboxes() {
    return Column(
      children: [
        _buildCheckbox('Low Risk', true),
        SizedBox(height: 8),
        _buildCheckbox('Medium Risk', true),
        SizedBox(height: 8),
        _buildCheckbox('High Risk', false),
      ],
    );
  }

  Widget _buildCheckbox(String label, bool isChecked) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: isChecked,
            onChanged: (value) {},
            activeColor: Color(0xFF2E7D32),
          ),
        ),
        SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _MobileFilters extends StatelessWidget {
  final String selectedCategory;
  final RangeValues priceRange;
  final RangeValues returnRange;
  final Function(String) onCategoryChanged;
  final Function(RangeValues) onPriceRangeChanged;
  final Function(RangeValues) onReturnRangeChanged;

  const _MobileFilters({
    required this.selectedCategory,
    required this.priceRange,
    required this.returnRange,
    required this.onCategoryChanged,
    required this.onPriceRangeChanged,
    required this.onReturnRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filters",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Show full filter dialog
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => _buildFullFilterBottomSheet(context),
                  );
                },
                child: Text(
                  "More Filters",
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                'All',
                'Urban Development',
                'Agricultural',
                'Commercial',
                'Residential',
                'Conservation',
                'Mixed-Use'
              ].map((category) {
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () => onCategoryChanged(category),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xFF2E7D32) : Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullFilterBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filters",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 24),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price range filter
                  Text(
                    "Investment Amount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "\$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  RangeSlider(
                    values: priceRange,
                    min: 100,
                    max: 50000,
                    divisions: 499,
                    activeColor: Color(0xFF2E7D32),
                    inactiveColor: Color(0xFFE8F5E9),
                    labels: RangeLabels(
                      "\$${priceRange.start.toInt()}",
                      "\$${priceRange.end.toInt()}",
                    ),
                    onChanged: onPriceRangeChanged,
                  ),
                  SizedBox(height: 24),
                  
                  // Return range filter
                  Text(
                    "Projected Annual Return",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${returnRange.start.toInt()}% - ${returnRange.end.toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  RangeSlider(
                    values: returnRange,
                    min: 5,
                    max: 20,
                    divisions: 15,
                    activeColor: Color(0xFF2E7D32),
                    inactiveColor: Color(0xFFE8F5E9),
                    labels: RangeLabels(
                      "${returnRange.start.toInt()}%",
                      "${returnRange.end.toInt()}%",
                    ),
                    onChanged: onReturnRangeChanged,
                  ),
                  SizedBox(height: 24),
                  
                  // Risk level filter
                  Text(
                    "Risk Level",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildCheckbox('Low Risk', true),
                  SizedBox(height: 8),
                  _buildCheckbox('Medium Risk', true),
                  SizedBox(height: 8),
                  _buildCheckbox('High Risk', false),
                  SizedBox(height: 24),
                  
                  // Property status
                  Text(
                    "Property Status",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildCheckbox('Active Funding', true),
                  SizedBox(height: 8),
                  _buildCheckbox('Fully Funded', false),
                  SizedBox(height: 8),
                  _buildCheckbox('Coming Soon', false),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    onCategoryChanged('All');
                    onPriceRangeChanged(RangeValues(100, 50000));
                    onReturnRangeChanged(RangeValues(5, 20));
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF2E7D32)),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Apply Filters",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String label, bool isChecked) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: isChecked,
            onChanged: (value) {},
            activeColor: Color(0xFF2E7D32),
          ),
        ),
        SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _InvestmentGridView extends StatelessWidget {
  final List<Map<String, dynamic>> investments;
  final BoxConstraints constraints;

  const _InvestmentGridView({
    required this.investments,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = constraints.maxWidth;
    
    // Determine number of columns based on screen width
    int crossAxisCount = 1;
    if (screenWidth > 1200) {
      crossAxisCount = 3;
    } else if (screenWidth > 800) {
      crossAxisCount = 2;
    }

    return Container(
      padding: EdgeInsets.all(24),
      child: investments.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "No investment opportunities match your criteria",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Try adjusting your filters to see more options",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${investments.length} Investment Opportunities",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    DropdownButton<String>(
                      value: 'Featured',
                      onChanged: (String? value) {},
                      items: ['Featured', 'Newest', 'Highest Return', 'Lowest Risk']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      underline: Container(
                        height: 2,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: investments.length,
                    itemBuilder: (context, index) {
                      final investment = investments[index];
                      return _InvestmentCard(
                        investment: investment,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _InvestmentCard extends StatelessWidget {
  final Map<String, dynamic> investment;

  const _InvestmentCard({
    required this.investment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property image and featured badge
          Stack(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    color: Colors.grey[400],
                    size: 48,
                  ),
                ),
              ),
              if (investment['featured'])
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Featured',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: Colors.black54,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category chip
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      investment['category'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  
                  // Property title
                  Text(
                    investment['title'],
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  
                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          investment['location'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  
                  // Investment details
                  Row(
                    children: [
                      _buildDetailItem(
                        'Min',
                        '\$${investment['minInvestment']}',
                      ),
                      SizedBox(width: 12),
                      _buildDetailItem(
                        'Return',
                        '${investment['projectedReturn']}%',
                      ),
                      SizedBox(width: 12),
                      _buildDetailItem(
                        'Risk',
                        investment['riskLevel'].toString().length > 8 
                            ? investment['riskLevel'].toString().substring(0, 8)
                            : investment['riskLevel'],
                      ),
                    ],
                  ),
                  
                  Spacer(),
                  
                  // Funding progress
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Funding Progress',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            '${(investment['fundingPercentage'] * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: investment['fundingPercentage'],
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  
                  // Invest button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Invest Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _SimpleFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.landscape, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'TheBoost',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            '© 2025 TheBoost. All rights reserved.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}