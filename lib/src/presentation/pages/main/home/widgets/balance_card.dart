import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

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
      height: 200.h,
     
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.bottomBarGrey200, 
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Flag
          SizedBox(
            width: 48.w,
            height: 48.w,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.black, AppColors.transparent],
                  stops: [1.0, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Center(
                child: Text(
                  flag,
                  style: TextStyle(
                    fontSize: 42.sp,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          
          // Amount
          Text(
            amount,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
              height: 1,
            ),
          ),
          SizedBox(height: 4.h),
          
          // Currency
          Text(
            currency,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}