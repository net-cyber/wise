import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';
import 'riverpod_drag/drag_splash_provider.dart';

class DragOnboardingPage extends ConsumerWidget {
  const DragOnboardingPage({super.key});

  void _handleDragUpdate(BuildContext context, WidgetRef ref, DragUpdateDetails details) {
    ref.read(dragSplashProvider.notifier).updateDragPosition(details.delta.dy);
    
    if (ref.read(dragSplashProvider.notifier).shouldNavigate) {
      context.goNamed(RouteName.onboarding);
    }
  }

  void _handleDragEnd(WidgetRef ref, DragEndDetails details) {
    if (ref.read(dragSplashProvider) > -200) {
      ref.read(dragSplashProvider.notifier).resetPosition();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dragPosition = ref.watch(dragSplashProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Image.asset(
                AppConstants.wiseLogo,
                width: 80.w,
                height: 80.h,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                  child: Container(
                    width: 70.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      image: DecorationImage(
                        image:  const AssetImage(AppConstants.splashBackground),
                        fit: BoxFit.cover,
                        opacity: 0.5,
                        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.surfaceContainerHighest, BlendMode.color),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onVerticalDragUpdate: (details) => _handleDragUpdate(context, ref, details),
                  onVerticalDragEnd: (details) => _handleDragEnd(ref, details),
                  child: Transform.translate(
                    offset: Offset(0, dragPosition),
                    child: Container(
                      width: 60.w,
                      height: 60.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.8), 
                      ),
                      child: Icon(
                        Icons.arrow_upward,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 30.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}