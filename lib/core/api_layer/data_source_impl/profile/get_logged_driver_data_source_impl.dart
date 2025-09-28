import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/models/response/profile/get_logged_driver.dart';
import 'package:tracking_app/features/profile/data/data_source/get_logged_driver_data_source.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';

@Injectable(as: GetLoggedDriverDataSource)
class GetLoggedDriverDataSourceImpl implements GetLoggedDriverDataSource {
  ApiClient apiClient;

  GetLoggedDriverDataSourceImpl(this.apiClient);

  @override
  Future<ApiResult<ProfileDriverEntity>> getLoggedDriverData() async {
    try {
      GetLoggedDriver getLoggedDriverDataResponse = await apiClient
          .getLoggedUserData();
      return ApiSuccessResult(
        getLoggedDriverDataResponse.driver!.toGetLoggedDriverEntity(),
      );
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          final message = responseData["message"] ?? "Unknown error";
          return ApiErrorResult<ProfileDriverEntity>(message.toString());
        }
        return ApiErrorResult<ProfileDriverEntity>(e.message ?? e.toString());
      }
      return ApiErrorResult<ProfileDriverEntity>(e.toString());
    }
  }
}
