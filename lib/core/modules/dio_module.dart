import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tracking_app/core/modules/shared_preferences_module.dart';
import 'package:tracking_app/core/resources/app_constants.dart';

@module
abstract class DioModule {
  @singleton
  Dio provideDio(PrettyDioLogger logger, SharedPrefHelper sharedPrefHelper) {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = sharedPrefHelper.getValue(AppConstants.tokenKey);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

    // إضافة الـ Logger
    dio.interceptors.add(logger);

    return dio;
  }

  @singleton
  PrettyDioLogger providePrettyDioLogger() {
    return PrettyDioLogger(
      request: true,
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    );
  }
}
