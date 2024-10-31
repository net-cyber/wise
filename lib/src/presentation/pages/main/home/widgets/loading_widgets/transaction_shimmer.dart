import 'package:flutter/material.dart';
import '../shimmer_container.dart';

class TransactionShimmer extends StatelessWidget {
  const TransactionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            ShimmerContainer(width: 150, height: 30),
            ShimmerContainer(width: 60, height: 20),
          ],
        ),
        const SizedBox(height: 16),
        _buildTransactionItemShimmer(),
        const SizedBox(height: 16),
        _buildTransactionItemShimmer(),
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
            children: const [
              ShimmerContainer(width: 150, height: 16),
              SizedBox(height: 4),
              ShimmerContainer(width: 100, height: 14),
            ],
          ),
        ),
        const ShimmerContainer(width: 80, height: 16),
      ],
    );
  }
}