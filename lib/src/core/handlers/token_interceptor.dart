import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/navigation/navigation_service.dart';
import 'package:wise/src/core/utils/local_storage.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/core/utils/app_helpers.dart';

class TokenInterceptor extends Interceptor {
  final bool requireAuth;

  TokenInterceptor({required this.requireAuth});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final String? accessToken = LocalStorage.instance.getAccessToken();
    if (requireAuth && accessToken != null) {
      options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Clear tokens
      LocalStorage.instance.deleteAccessToken();
      LocalStorage.instance.deleteRefreshToken();
      
      final context = NavigationService.currentContext;
      if (context != null) {
        // Show error message
        AppHelpers.showCheckFlash(
          context,
          'Session expired. Please login again.',
        );

        // Navigate to login
        context.goNamed(RouteName.login);
      }
    }
    return handler.next(err);
  }
}
