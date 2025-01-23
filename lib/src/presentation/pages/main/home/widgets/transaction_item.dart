import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;

  const TransactionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
              child: Icon(
                icon,
               
                size: 23.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}