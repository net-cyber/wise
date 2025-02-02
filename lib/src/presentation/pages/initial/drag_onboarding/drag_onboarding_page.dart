import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';
import 'riverpod_drag/drag_splash_provider.dart';

class DragOnboardingPage extends ConsumerStatefulWidget {
  const DragOnboardingPage({super.key});

  @override
  ConsumerState<DragOnboardingPage> createState() => _DragOnboardingPageState();
}

class _DragOnboardingPageState extends ConsumerState<DragOnboardingPage> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(BuildContext context, DragUpdateDetails details) {
    ref.read(dragSplashProvider.notifier).updateDragPosition(details.delta.dy);
    
    if (ref.read(dragSplashProvider.notifier).shouldNavigate) {
      _fadeController.stop();
      context.goNamed(RouteName.onboarding);
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (ref.read(dragSplashProvider) > -200) {
      ref.read(dragSplashProvider.notifier).resetPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dragPosition = ref.watch(dragSplashProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                AppConstants.wiseLogo,
                width: 120.w,
                height: 120.h,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildDragIndicator(context, dragPosition),
                  32.verticalSpace,
                  AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeAnimation.value,
                        child: Text(
                          'Swipe up to begin',
                          style: TextStyle(
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      );
                    },
                  ),
                  48.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragIndicator(BuildContext context, double dragPosition) {
    return GestureDetector(
      onVerticalDragUpdate: (details) => _handleDragUpdate(context, details),
      onVerticalDragEnd: _handleDragEnd,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 2.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
          Transform.translate(
            offset: Offset(0, dragPosition),
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary.withOpacity(_fadeAnimation.value),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}