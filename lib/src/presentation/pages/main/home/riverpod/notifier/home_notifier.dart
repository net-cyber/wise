import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/state/home_state.dart';


class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(HomeState()) {
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.delayed(const Duration(seconds: 2));
    
    state = state.copyWith(
      isLoading: false,
      initials: 'JS',
      earnAmount: '100',
      balances: [
        BalanceCardData(
          flag: '🇸🇬',
          amount: '15.00',
          currency: 'Singapore Dollar',
        ),
        BalanceCardData(
          flag: '🇦🇺',
          amount: '0.00',
          currency: 'Australian Dollar',
        ),
      ],
      transactions: [
        TransactionData(
          icon: Icons.arrow_upward,
          title: 'For your Wise card',
          subtitle: 'Paid · Today',
          amount: '9 SGD',
        ),
        TransactionData(
          icon: Icons.add,
          title: 'To your SGD balance',
          subtitle: 'Added · Today',
          amount: '24 SGD',
        ),
      ],
    );
  }

  void refreshData() {
    state = state.copyWith(isLoading: true);
    _initializeData();
  }
}