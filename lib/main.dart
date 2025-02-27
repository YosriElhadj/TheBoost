import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/auth_page.dart';
import 'package:my_flutter_app/features_page.dart';
import 'package:my_flutter_app/howitworks_page.dart';
import 'package:my_flutter_app/investing_page.dart';
import 'package:my_flutter_app/learn_more_page.dart';

void main() {
  runApp(TheBoostApp());
}

class TheBoostApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheBoost - Land Investment via Tokenization',
      theme: ThemeData(
        primaryColor: Color(0xFF2E7D32),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF2E7D32),
          secondary: Color(0xFF388E3C),
          surface: Colors.white,
          background: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(),
            HeroSection(),
            FeatureSection(),
            HowItWorksSection(),
            InvestmentAdvantagesSection(),
            TestimonialSection(),
            FAQSection(),
            CallToActionSection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Logo
              Icon(Icons.landscape, color: Color(0xFF2E7D32), size: 32),
              SizedBox(width: 8),
              Text(
                'TheBoost',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
          // Navigation links
          Row(
            children: [
              NavLink('Home'),
              NavLink('Features'),
              NavLink('How It Works'),
              NavLink('FAQ'),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthPage()));},
                child: Text(
                  'Get Started',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NavLink extends StatelessWidget {
  final String title;
  
  NavLink(this.title);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80, 
        vertical: isMobile ? 40 : 80
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFE8F5E9),
          ],
        ),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildHeroContent(context, isMobile),
            )
          : Row(
              children: _buildHeroContent(context, isMobile),
            ),
    );
  }
  
  List<Widget> _buildHeroContent(BuildContext context, bool isMobile) {
    return [
      Expanded(
        flex: 5,
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Invest in Land\nThe Smart Way',
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
              style: GoogleFonts.montserrat(
                fontSize: isMobile ? 32 : 48,
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Buy, sell, and exchange tokenized land assets with full transparency and security through blockchain technology.',
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                height: 1.5,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>InvestingPage()));},
                  child: Text(
                    'Start Investing',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
                SizedBox(width: 16),
                TextButton.icon(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>HowItWorksPage()));},
                  icon: Icon(Icons.play_circle_outline, color: Color(0xFF2E7D32)),
                  label: Text(
                    'How it works',
                    style: TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      if (!isMobile) SizedBox(width: 40),
      if (!isMobile)
        Expanded(
          flex: 5,
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.image, size: 64, color: Colors.grey[400]),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      "Application Screenshot",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      if (isMobile) SizedBox(height: 40),
    ];
  }
}

class FeatureSection extends StatelessWidget {
  final List<Map<String, dynamic>> features = [
    {
      'icon': Icons.token,
      'title': 'Asset Tokenization',
      'description': 'Convert land ownership into digital tokens for fractional investing and easier transfers.'
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'Buy & Sell Tokens',
      'description': 'Trade land tokens easily through our intuitive platform with minimal fees.'
    },
    {
      'icon': Icons.security,
      'title': 'Blockchain Security',
      'description': 'Secure all transactions and ownership records with immutable blockchain technology.'
    },
    {
      'icon': Icons.show_chart,
      'title': 'Market Analytics',
      'description': 'Access detailed market data and trends to make informed investment decisions.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        children: [
          Text(
            'Key Features',
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Everything you need to invest in land assets with confidence',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            children: features.map((feature) {
              return Container(
                width: isMobile ? double.infinity : 250,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        feature['icon'],
                        color: Color(0xFF2E7D32),
                        size: 28,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      feature['title'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      feature['description'],
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class HowItWorksSection extends StatelessWidget {
  final List<Map<String, dynamic>> steps = [
    {
      'number': '01',
      'title': 'Create an Account',
      'description': 'Sign up and complete verification to access investment opportunities.'
    },
    {
      'number': '02',
      'title': 'Browse Properties',
      'description': 'Explore available land offerings with detailed information and analytics.'
    },
    {
      'number': '03',
      'title': 'Purchase Tokens',
      'description': 'Buy tokens representing shares in land properties of your choice.'
    },
    {
      'number': '04',
      'title': 'Manage Portfolio',
      'description': 'Track performance, receive updates, and sell or trade tokens when ready.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80),
      color: Color(0xFFF5F5F5),
      child: Column(
        children: [
          Text(
            'How It Works',
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Simple steps to start your land investment journey',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 60),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Wrap(
              spacing: 30,
              runSpacing: 50,
              alignment: WrapAlignment.center,
              children: steps.map((step) {
                return Container(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFF2E7D32),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            step['number'],
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        step['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        step['description'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class InvestmentAdvantagesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        children: [
          Text(
            'Why Invest with TheBoost',
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 60),
          isMobile
              ? Column(
                  children: [
                    _buildAdvantageContent(context),
                    SizedBox(height: 40),
                    _buildAdvantageImage(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildAdvantageContent(context),
                    ),
                    SizedBox(width: 60),
                    Expanded(
                      flex: 6,
                      child: _buildAdvantageImage(),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
  
  Widget _buildAdvantageContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdvantageItem(
          title: 'Low Barrier to Entry',
          description: 'Start investing in land with as little as \$100, making real estate accessible to everyone.',
        ),
        SizedBox(height: 30),
        AdvantageItem(
          title: 'Diversify Your Portfolio',
          description: 'Spread your investment across multiple properties to reduce risk and optimize returns.',
        ),
        SizedBox(height: 30),
        AdvantageItem(
          title: 'High Liquidity',
          description: 'Trade tokens easily without the lengthy processes associated with traditional land sales.',
        ),
        SizedBox(height: 30),
        AdvantageItem(
          title: 'Transparent Ownership',
          description: 'All ownership records are stored on the blockchain, providing complete transparency and security.',
        ),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>FeaturesPage()));},
          child: Text(
            'Learn More',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
      ],
    );
  }
  
  Widget _buildAdvantageImage() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Container(
            color: Colors.grey[300],
            child: Center(
              child: Icon(Icons.image, size: 64, color: Colors.grey[400]),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Text(
                "Investment Portfolio View",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdvantageItem extends StatelessWidget {
  final String title;
  final String description;
  
  AdvantageItem({required this.title, required this.description});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.check,
            color: Color(0xFF2E7D32),
            size: 24,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TestimonialSection extends StatelessWidget {
  final List<Map<String, dynamic>> testimonials = [
    {
      'name': 'Sarah Johnson',
      'role': 'Small Business Owner',
      'comment': 'TheBoost made it possible for me to invest in real estate with a limited budget. The platform is intuitive and the tokenization model really works!',
      'avatar': 'assets/avatar1.jpg',
    },
    {
      'name': 'Michael Chen',
      'role': 'Financial Advisor',
      'comment': 'I recommend TheBoost to all my clients looking to diversify their portfolios. The blockchain security and transparency gives everyone peace of mind.',
      'avatar': 'assets/avatar2.jpg',
    },
    {
      'name': 'Emma Rodriguez',
      'role': 'First-time Investor',
      'comment': 'Never thought I could own a piece of prime real estate until I found TheBoost. Now I have investments in three different properties!',
      'avatar': 'assets/avatar3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80),
      color: Color(0xFFF5F5F5),
      child: Column(
        children: [
          Text(
            'What Our Users Say',
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 60),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: testimonials.map((testimonial) {
                return Container(
                  width: 320,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.05),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.format_quote, color: Color(0xFF2E7D32), size: 32),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        testimonial['comment'],
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.black87,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(Icons.person, color: Colors.grey[400]),
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                testimonial['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                testimonial['role'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class FAQSection extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'What is land tokenization?',
      'answer': 'Land tokenization is the process of converting land ownership rights into digital tokens on a blockchain, allowing for fractional ownership and easier trading of real estate assets.'
    },
    {
      'question': 'How is my investment secured?',
      'answer': 'All investments on TheBoost are secured using blockchain technology, which creates immutable records of ownership. Additionally, all properties are legally vetted and backed by proper documentation.'
    },
    {
      'question': 'What are the minimum investment amounts?',
      'answer': 'You can start investing with as little as \$100, allowing you to purchase fractional ownership in premium land properties.'
    },
    {
      'question': 'How do I sell my tokens?',
      'answer': 'You can list your tokens for sale directly on our platform at any time. Once another investor purchases them, the transaction is processed immediately via our secure blockchain system.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        children: [
          Text(
            'Frequently Asked Questions',
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 60),
          Wrap(
            spacing: isMobile ? 0 : 30,
            runSpacing: 20,
            children: faqs.map((faq) {
              return Container(
                width: isMobile ? double.infinity : 500,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  title: Text(
                    faq['question']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  iconColor: Color(0xFF2E7D32),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 24, right: 16),
                      child: Text(
                        faq['answer']!,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CallToActionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2E7D32),
            Color(0xFF1B5E20),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Start Investing in Land?',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),
          Container(
            width: isMobile ? double.infinity : 600,
            child: Text(
              'Join thousands of investors who are already building wealth through tokenized land assets. Start with as little as \$100 today.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Create Your Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF2E7D32),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
          SizedBox(height: 24),
          TextButton(
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>LearnMorePage()));},
            child: Text(
              'Learn More About TheBoost',
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      color: Colors.grey[900],
      child: Column(
        children: [
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildFooterContent(context, isMobile),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildFooterContent(context, isMobile),
                ),
          SizedBox(height: 40),
          Divider(color: Colors.grey[800]),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2025 TheBoost. All rights reserved.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],
                ),
              ),
              Row(
                children: [
                  FooterIconButton(Icons.facebook),
                  FooterIconButton(Icons.one_x_mobiledata),
                  FooterIconButton(Icons.dataset_linked_rounded),
                  FooterIconButton(Icons.email),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  List<Widget> _buildFooterContent(BuildContext context, bool isMobile) {
    return [
      Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Icon(Icons.landscape, color: Colors.white, size: 32),
                SizedBox(width: 8),
                Text(
                  'TheBoost',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              width: isMobile ? 300 : 280,
              child: Text(
                'TheBoost is revolutionizing land investment through blockchain technology and asset tokenization.',
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 40, height: isMobile ? 40 : 0),
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            FooterHeading('Company'),
            FooterLink('About Us'),
            FooterLink('Our Team'),
            FooterLink('Careers'),
            FooterLink('Press'),
            FooterLink('Contact'),
          ],
        ),
      ),
      SizedBox(width: 40, height: isMobile ? 40 : 0),
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            FooterHeading('Resources'),
            FooterLink('Blog'),
            FooterLink('Help Center'),
            FooterLink('Investment Guide'),
            FooterLink('Tokenization Explained'),
            FooterLink('API Documentation'),
          ],
        ),
      ),
      SizedBox(width: 40, height: isMobile ? 40 : 0),
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            FooterHeading('Legal'),
            FooterLink('Terms of Service'),
            FooterLink('Privacy Policy'),
            FooterLink('Compliance'),
            FooterLink('Security'),
            FooterLink('Cookies'),
          ],
        ),
      ),
    ];
  }
}

class FooterHeading extends StatelessWidget {
  final String title;
  
  FooterHeading(this.title);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FooterLink extends StatelessWidget {
  final String title;
  
  FooterLink(this.title);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {},
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}

class FooterIconButton extends StatelessWidget {
  final IconData icon;
  
  FooterIconButton(this.icon);
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon),
      color: Colors.grey[400],
      iconSize: 20,
    );
  }
}