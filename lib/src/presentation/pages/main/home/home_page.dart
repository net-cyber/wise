import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/provider/home_provider.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/state/home_state.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/balance_card.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/loading_widgets/balance_card_shimmer.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/loading_widgets/transaction_shimmer.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/shimmer_container.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/transaction_item.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/filter_chip_button.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/loading_widgets/filter_chips_shimmer.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/loading_widgets/top_bar_shimmer.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              
             
              state.isLoading 
                ? const ShimmerContainer(width: 150, height: 40)
                : const Text(
                    'Account',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
              const SizedBox(height: 16),
              
              
               SizedBox(height: 16.h),
              
              state.isLoading 
                ? const BalanceCardShimmer() 
                : _buildBalanceCards(context, state.balances),
                
              const SizedBox(height: 24),
              
              state.isLoading
                ? const TransactionShimmer()
                : _buildTransactions(context, state.transactions),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCards(BuildContext context, List<BalanceCardData> balances) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: balances.map((balance) => Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: BalanceCard(
            flag: balance.flag,
            amount: balance.amount,
            currency: balance.currency,
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildTransactions(BuildContext context, List<TransactionData> transactions) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Transactions",
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
               
              ),
            ),
            const Spacer(),
            Text(
              "See all",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                
                
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ...transactions.map((transaction) => Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: TransactionItem(
            icon: transaction.icon,
            title: transaction.title,
            subtitle: transaction.subtitle,
            amount: transaction.amount,
          ),
        )).toList(),
      ],
    );
  }
}

