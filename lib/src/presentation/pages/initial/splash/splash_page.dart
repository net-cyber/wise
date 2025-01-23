
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/presentation/widgets/loading.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/core/utils/utils.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';
import 'riverpod/provider/splash_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref.read(splashProvider.notifier).getUserStatus(
          context,
          
        );
      },
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LoadingWidget(),
    );
  }
}
