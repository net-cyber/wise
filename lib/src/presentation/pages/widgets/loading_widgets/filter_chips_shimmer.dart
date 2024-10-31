import 'package:flutter/material.dart';
import '../shimmer_container.dart';

class FilterChipsShimmer extends StatelessWidget {
  const FilterChipsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
}