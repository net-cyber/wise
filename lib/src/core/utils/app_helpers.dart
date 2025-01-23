import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class AppHelpers {
  AppHelpers._();


  static showNoConnectionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: Text(
        'No internet connection',
        style: GoogleFonts.k2d(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
      action: SnackBarAction(
        label: 'Close',
        disabledTextColor: Colors.white,
        textColor: Colors.yellow,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

    static showCheckFlash(BuildContext context, String text) {
    return showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (BuildContext context, FlashController controller) {
        return Flash(
          controller: controller,
          // backgroundColor: AppColors.mainBack,
          position: FlashPosition.top,
          // borderRadius: BorderRadius.circular(8.r),
          // behavior: FlashBehavior.floating,
          // margin: REdgeInsets.all(15),
          // brightness: Brightness.light,
          // barrierBlur: 1.5.r,
          // barrierColor: Colors.black38,
          // barrierDismissible: true,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.primaryGreen,
                width: 2.r,
              ),
            ),
            child: Padding(
              padding: REdgeInsets.all(15),
              child: Text(
                text,
                style: GoogleFonts.k2d(
                  color: AppColors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

}
