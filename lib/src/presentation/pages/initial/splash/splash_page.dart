import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _dragPosition = 0;

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      if (details.delta.dy < 0) {
        _dragPosition += details.delta.dy;
        _dragPosition = _dragPosition.clamp(-240, 0);
      }
    });

    if (_dragPosition <= -200) {
      context.goNamed(RouteName.onboarding);
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dragPosition > -200) {
      setState(() {
        _dragPosition = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: SafeArea(
        
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Logo
            Center(
              child: Image.asset(
                AppConstants.wiseLogo,
                width: 80.w,
                height: 80.h,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            // Movable arrow with background image
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Static background image container
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                    // bottom corners will remain square
                  ),
                  child: Container(
                    width: 70.w,
                    height: 300.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppConstants.splashBackground),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Movable arrow icon
                GestureDetector(
                  onVerticalDragUpdate: _handleDragUpdate,
                  onVerticalDragEnd: _handleDragEnd,
                  child: Transform.translate(
                    offset: Offset(0, _dragPosition),
                    child: Container(
                      width: 60.w,
                      height: 60.h,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
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