import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wise/src/presentation/pages/widgets/balance_card.dart';
import 'package:wise/src/presentation/pages/widgets/loading_widgets/balance_card_shimmer.dart';
import 'package:wise/src/presentation/pages/widgets/loading_widgets/transaction_shimmer.dart';
import 'package:wise/src/presentation/pages/widgets/shimmer_container.dart';
import 'package:wise/src/presentation/pages/widgets/top_bar.dart';
import 'package:wise/src/presentation/pages/widgets/transaction_item.dart';
import 'package:wise/src/presentation/pages/widgets/filter_chip_button.dart';
import 'package:wise/src/presentation/pages/widgets/loading_widgets/filter_chips_shimmer.dart';
import 'package:wise/src/presentation/pages/widgets/loading_widgets/top_bar_shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // Home
        break;
      case 1: // Card
        // context.goNamed(RouteName.card);
        break;
      case 2: // Send
        // context.goNamed(RouteName.send);
        break;
      case 3: // Recipients
        // context.goNamed(RouteName.recipients);
        break;
      case 4: // Manage
        // context.goNamed(RouteName.manage);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _isLoading 
                ? const TopBarShimmer()
                : const TopBar(
                    initials: 'JS',
                    earnAmount: '100',
                  ),
              const SizedBox(height: 24),
              
              _isLoading 
                ? const ShimmerContainer(width: 150, height: 40)
                : const Text(
                    'Account',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
              const SizedBox(height: 16),
              
              _isLoading 
                ? const FilterChipsShimmer()
                : const FilterChipButton(
                    label: 'All',
                    isSelected: true,
                  ),
              const SizedBox(height: 16),
              
              _isLoading ? const BalanceCardShimmer() : _buildBalanceCards(),
              const SizedBox(height: 24),
              
              _isLoading
                ? const TransactionShimmer()
                : const Column(
                    children: [
                      TransactionItem(
                        icon: Icons.arrow_upward,
                        title: 'For your Wise card',
                        subtitle: 'Paid · Today',
                        amount: '9 SGD',
                      ),
                      const SizedBox(height: 16),
                      const TransactionItem(
                        icon: Icons.add,
                        title: 'To your SGD balance',
                        subtitle: 'Added · Today',
                        amount: '24 SGD',
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Card'),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'Send'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Recipients'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Manage'),
        ],
      ),
    );
  }


  Widget _buildBalanceCards() {
    return const Row(
      children: [
        Expanded(
          child: BalanceCard(
            flag: '🇸🇬',
            amount: '15.00',
            currency: 'Singapore Dollar',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: BalanceCard(
            flag: '🇦🇺',
            amount: '0.00',
            currency: 'Australian Dollar',
          ),
        ),
      ],
    );
  }

}

