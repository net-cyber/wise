import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:wise/src/core/constants/app_constants.dart';

/// Basic example playing a Rive animation from a packaged asset.
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          
          borderRadius: BorderRadius.circular(16),
        ),
        child: const RiveAnimation.asset(
          AppConstants.loadingAnimation,
          fit: BoxFit.contain,
          ),
      ),
      
    );
  }
}