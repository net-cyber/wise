import 'package:flutter/material.dart';
import 'package:wise/src/presentation/pages/main/home/widgets/shimmer_container.dart';

class BalanceCardShimmer extends StatelessWidget {
  const BalanceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
}