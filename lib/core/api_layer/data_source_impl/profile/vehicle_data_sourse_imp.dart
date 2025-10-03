import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/features/profile/domain/entities/vehicle.dart';

import '../../../../features/profile/data/data_source/get_vehicl_info.dart';
import '../../../../features/profile/domain/entities/get_logged_driver_entity.dart';
import '../../api_result/api_result.dart';
import '../../models/response/profile/get_logged_driver.dart';

@Injectable(as: GetVehicleInfo)
class VehicleDataSourceImpl implements GetVehicleInfo {
  late ApiClient apiClient;

  VehicleDataSourceImpl(this.apiClient);

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

  @override
  Future<ApiResult<VehicleEntity>> getVehicleInfo() async {
    try {
      VehicleEntity vehicleInfo = await apiClient.getVehicleInfo();
      return ApiSuccessResult(vehicleInfo);
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          final message = responseData["message"] ?? "Unknown error";
          return ApiErrorResult<VehicleEntity>(message.toString());
        }
        return ApiErrorResult<VehicleEntity>(e.message ?? e.toString());
      }
      return ApiErrorResult<VehicleEntity>(e.toString());
    }
  }
}