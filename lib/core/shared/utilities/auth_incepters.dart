import 'package:dio/dio.dart';
import 'package:accounting/core/constants/app_strings.dart';
import 'package:accounting/core/data/storage_services/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage secureStorage;

  AuthInterceptor(this.secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.getToken();

    if (token != null) {
      options.baseUrl=AppStrings.BASE_URL;
      options.queryParameters['api_token']=token;
/*
      options.headers['Authorization'] = 'Bearer $token';
*/
      options.headers['Content-Type'] = 'application/json';
    }

    print("HEADERS: ${options.headers}");
    super.onRequest(options, handler);
  }
}
