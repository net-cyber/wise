import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/app_widget.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/core/di/dependancy_manager.dart';
import 'package:wise/src/core/utils/local_storage.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

void main() async {
  setUpDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.getInstance();
     SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(const ProviderScope(child: AppWidget()));
}


