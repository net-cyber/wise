

import 'package:dio/dio.dart';
import 'package:wise/src/core/utils/local_storage.dart';

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
}
