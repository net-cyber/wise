import 'package:fluttertoast/fluttertoast.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppHelpers {
  AppHelpers._();

  static showNoConnectionSnackBar(BuildContext context) {
    Fluttertoast.showToast(
      msg: 'No internet connection',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.teal,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static showCheckFlash(BuildContext context, String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.onPrimary,
      fontSize: 13.0,
    );
  }

  static showErrorFlash(BuildContext context, String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Theme.of(context).colorScheme.error,
      textColor: Theme.of(context).colorScheme.onError,
      fontSize: 13.0,
    );
  }
}
