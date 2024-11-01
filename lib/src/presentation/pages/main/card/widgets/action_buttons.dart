import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          icon: Icons.add,
          label: 'Add money',
          onTap: () {},
        ),
        _buildActionButton(
          icon: Icons.credit_card_outlined,
          label: 'Card details',
          onTap: () {},
        ),
        _buildActionButton(
          icon: Icons.ac_unit,
          label: 'Freeze card',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56.w,
            height: 56.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryGreen,
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: 26.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}