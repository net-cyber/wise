import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/presentation/riverpod/provider/app_provider.dart';

/// Basic example playing a Rive animation from a packaged asset.
class LoadingWidget extends ConsumerWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appProvider).isDarkMode;
    return  Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color:  themeMode ? Colors.black : Colors.white,
          
          borderRadius: BorderRadius.circular(16),
        ),
        child:  RiveAnimation.asset(
           themeMode ? AppConstants.loadingAnimationDark : AppConstants.loadingAnimation,
          fit: BoxFit.contain,
          ),
      ),
      
    );
  }
}