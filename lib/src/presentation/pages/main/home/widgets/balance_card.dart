import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalanceCard extends StatelessWidget {
  final String flag;
  final String amount;
  final String currency;
  final String name;
  final double rate;

  const BalanceCard({
    super.key,
    required this.flag,
    required this.amount,
    required this.currency,
    required this.name,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 200.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flag and Currency
              Row(
                children: [
                  CountryFlag.fromCountryCode(
                    currency.substring(0, 2),
                    height: 30.h,
                    width: 40.w,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    currency,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Amount
              Text(
                amount,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  height: 1,
                  letterSpacing: -0.5,
                ),
              ),
              
              SizedBox(height: 8.h),
              
              // Exchange rate indicator
              Row(
                children: [
                 Text(
                  '${rate.toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                 ),
                  SizedBox(width: 4.w),
                  Text(
                    '$name',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}