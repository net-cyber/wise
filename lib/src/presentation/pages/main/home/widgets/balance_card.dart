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
      width: MediaQuery.of(context).size.width * 0.6,
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
          Container(
            width: 32.w,
            height: 32.w,
            child: Text(
              flag,
              style: TextStyle(
                fontSize: 24.sp,
              ),
            ),
          ),
          const Spacer(),
          
          // Amount
          Text(
            amount,
            style: TextStyle(
              fontSize: 24.sp,
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
              fontSize: 14.sp,
              color: AppColors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}