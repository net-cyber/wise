import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wise/src/presentation/pages/widgets/balance_card.dart';
import 'package:wise/src/presentation/pages/widgets/loading_widgets/balance_card_shimmer.dart';
import 'package:wise/src/presentation/pages/widgets/loading_widgets/transaction_shimmer.dart';
import 'package:wise/src/presentation/pages/widgets/shimmer_container.dart';
import 'package:wise/src/presentation/pages/widgets/transaction_item.dart';

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
                ? const BalanceCardShimmer()
                : const Row(
                    children: [
                      Expanded(
                        child: BalanceCard(
                          flag: 'SG',
                          amount: '15.00',
                          currency: 'Singapore Dollar',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: BalanceCard(
                          flag: 'AU',
                          amount: '0.00',
                          currency: 'Australian Dollar',
                        ),
                      ),
                    ],
                  ),
              const SizedBox(height: 24),
              
              // Account text with shimmer
              _isLoading 
                ? _buildShimmerText(width: 150, height: 40) 
                : const Text(
                    'Account',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
              const SizedBox(height: 16),
              
              // Filter chips with shimmer
              _isLoading ? _buildFilterChipsShimmer() : _buildFilterChips(),
              const SizedBox(height: 16),
              
              // Balance cards with shimmer
              _isLoading ? _buildBalanceCardsShimmer() : _buildBalanceCards(),
              const SizedBox(height: 24),
              
              // Transactions section with shimmer
              _isLoading
                ? const TransactionShimmer()
                : Column(
                    children: const [
                      TransactionItem(
                        icon: Icons.arrow_upward,
                        title: 'For your Wise card',
                        subtitle: 'Paid · Today',
                        amount: '9 SGD',
                      ),
                      SizedBox(height: 16),
                      TransactionItem(
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

 

  Widget _buildTopBarShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShimmerContainer(
          width: 40,
          height: 40,
          borderRadius: BorderRadius.circular(20),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShimmerContainer(
                width: 100,
                height: 36,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(width: 12),
              ShimmerContainer(
                width: 24,
                height: 24,
                borderRadius: BorderRadius.circular(12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChipsShimmer() {
    return Row(
      children: [
        ShimmerContainer(
          width: 80,
          height: 32,
          borderRadius: BorderRadius.circular(16),
        ),
        const SizedBox(width: 8),
        ShimmerContainer(
          width: 100,
          height: 32,
          borderRadius: BorderRadius.circular(16),
        ),
      ],
    );
  }

  Widget _buildBalanceCardsShimmer() {
    return Row(
      children: [
        Expanded(
          child: ShimmerContainer(
            width: double.infinity,
            height: 120,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ShimmerContainer(
            width: double.infinity,
            height: 120,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }


  Widget _buildTransactionItemShimmer() {
    return Row(
      children: [
        ShimmerContainer(
          width: 48,
          height: 48,
          borderRadius: BorderRadius.circular(24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShimmerText(width: 150, height: 16),
              const SizedBox(height: 4),
              _buildShimmerText(width: 100, height: 14),
            ],
          ),
        ),
        _buildShimmerText(width: 80, height: 16),
      ],
    );
  }

  Widget _buildShimmerText({
    required double width,
    required double height,
  }) {
    return ShimmerContainer(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(4),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: const Text('YX', style: TextStyle(color: Colors.black)),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFB5EA9A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Earn \$115'),
              ),
              const Icon(Icons.notifications_outlined),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Row(
      children: [
        FilterChip(
          selected: false,
          showCheckmark: false,
          label: const Text(
            'All',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.transparent,
          selectedColor: Colors.transparent,
          shape: StadiumBorder(
            side: BorderSide(color: Colors.grey[300]!),
          ),
          onSelected: (bool selected) {},
        ),
        const SizedBox(width: 8),
        FilterChip(
          selected: true,
          showCheckmark: false,
          label: const Text(
            'Interest',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.grey[200],
          selectedColor: Colors.transparent,
          shape: const StadiumBorder(),
          onSelected: (bool selected) {},
        ),
      ],
    );
  }

  Widget _buildBalanceCards() {
    return const Row(
      children: [
        Expanded(
          child: BalanceCard(
            flag: 'SG',
            amount: '15.00',
            currency: 'Singapore Dollar',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: BalanceCard(
            flag: 'AU',
            amount: '0.00',
            currency: 'Australian Dollar',
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Transactions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See all'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _TransactionItem(
          icon: Icons.arrow_upward,
          title: 'For your Wise card',
          subtitle: 'Paid · Today',
          amount: '9 SGD',
        ),
        const SizedBox(height: 16),
        _TransactionItem(
          icon: Icons.add,
          title: 'To your SGD balance',
          subtitle: 'Added · Today',
          amount: '24 SGD',
        ),
      ],
    );
  }
}

// Helper widget for balance cards
class _BalanceCard extends StatelessWidget {
  final String flag;
  final String amount;
  final String currency;

  const _BalanceCard({
    required this.flag,
    required this.amount,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            child: Text(flag),
          ),
          const SizedBox(height: 16),
          Text(
            amount,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            currency,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

// Helper widget for transaction items
class _TransactionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;

  const _TransactionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, color: Colors.black),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}