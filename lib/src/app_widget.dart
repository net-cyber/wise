import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/core/router/router.dart';
import 'package:wise/src/core/router/slide_transition.dart';
import 'package:wise/src/presentation/riverpod/provider/app_provider.dart';
import 'package:wise/src/presentation/theme/app_theme.dart';


class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterNativeSplash.remove();
    final state = ref.watch(appProvider);
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        darkTheme: AppTheme.darkTheme().copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomTransitionBuilder(),
                },
              ),
            ),
        theme: AppTheme.lightTheme().copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomTransitionBuilder(),
                },
              ),
        ),
      ),
    );
  }
}