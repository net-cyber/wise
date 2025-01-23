import 'package:flutter/material.dart';
import '../shimmer_container.dart';

class TopBarShimmer extends StatelessWidget {
  const TopBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
}