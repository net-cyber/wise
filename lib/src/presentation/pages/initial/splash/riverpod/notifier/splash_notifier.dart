
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/core/utils/app_helpers.dart';
import 'package:wise/src/core/utils/utils.dart';
import 'package:wise/src/presentation/pages/initial/splash/riverpod/state/splash_state.dart';

class SplashNotifier extends StateNotifier<SplashState> {
 

  SplashNotifier()
      : super(const SplashState());

  Future<void> getUserStatus(
    BuildContext context, 
  ) async {
    log('getUserStatus');

    state = state.copyWith(isLoading: true);
    try {
      final token = LocalStorage.instance.getAccessToken();
      log('token: $token');
      if (token != null) {
        log('token is not null');
        state = state.copyWith(isLoading: false);
        context.goNamed(RouteName.home);
        
      } else if (token == null) {
        log('token is null');
        state = state.copyWith(isLoading: false);
        context.goNamed(RouteName.dragOnboarding);
      }
    } catch (e) {
      state = state.copyWith(isError: true);
    } 
  }


}
