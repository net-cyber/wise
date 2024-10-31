import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final String flag;
  final String amount;
  final String currency;

  const BalanceCard({
    super.key,
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