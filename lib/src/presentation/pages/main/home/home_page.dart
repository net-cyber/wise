import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/core/presentation/widgets/loading.dart';
import 'package:wise/src/model/exchage_rate_response.dart';
import 'package:wise/src/model/transaction_history_response.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/provider/home_provider.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/state/home_state.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/balance_card.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/shimmer_container.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/transaction_item.dart';
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
          padding: EdgeInsets.all(16.0.w),
          child: state.isLoading ? const LoadingWidget() : SingleChildScrollView(
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
              
                  _buildBalanceCards(context, state.exchangeRates),
                  
                const SizedBox(height: 24),
                
                _buildTransactions(context, state.transactionHistory?.transactions ?? []),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCards(BuildContext context, List<ExchangeRateResponse> exchangeRates) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: exchangeRates.map((exchangeRate) => Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: BalanceCard(
            flag: exchangeRate.currencyCode,
            amount: exchangeRate.rate.toString(),
            currency: exchangeRate.currencyCode,
            name: exchangeRate.name,
            rate: exchangeRate.rate,
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildTransactions(BuildContext context, List<TransactionList> transactions) {
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
            icon: Icons.arrow_forward_ios,
            title: transaction.counterparty,
            subtitle: transaction.type,
            amount: transaction.amount.toString(),
            status: transaction.status,
            timestamp: transaction.timestamp,
          ),
        )),
      ],
    );
  }
}

