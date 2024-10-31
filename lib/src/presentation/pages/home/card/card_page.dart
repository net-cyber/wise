import 'package:flutter/material.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'dart:ui';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
         const SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            expandedHeight: 160,
            collapsedHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.0,
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: const Text(
                'Cards',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Convert the body content to slivers
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Carousel
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(right: index == 0 ? 16 : 0),
                      width: MediaQuery.of(context).size.width - 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage(AppConstants.wise_card),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Card Details Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Digital card ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            
                            const SizedBox(width: 8),

                            const Text(
                              '••••',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Bank card style blur
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: const Text(
                                  '1234',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildActionButton(
                            icon: Icons.add,
                            label: 'Add money',
                            onTap: () {},
                          ),
                          _buildActionButton(
                            icon: Icons.credit_card_outlined,
                            label: 'Card details',
                            onTap: () {},
                          ),
                          _buildActionButton(
                            icon: Icons.ac_unit,
                            label: 'Freeze card',
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      
                      // Apple Wallet Button
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.apple,
                                size: 24,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'pay',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Add to Apple Wallet',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.chevron_right,
                                size: 28,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFB5EA9A),
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}