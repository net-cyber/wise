import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class AppleWalletButton extends StatelessWidget {
  const AppleWalletButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              Icons.apple,
              size: 24.sp,
              color: AppColors.black,
            ),
            SizedBox(width: 8.w),
            const Text(
              'pay',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 12.w),
            const Text(
              'Add to Apple Wallet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Icon(
              Icons.chevron_right,
              size: 28.sp,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}