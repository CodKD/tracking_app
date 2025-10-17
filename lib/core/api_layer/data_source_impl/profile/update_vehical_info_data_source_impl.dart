import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/models/request/update_vehical_request_dto.dart';
import 'package:tracking_app/core/api_layer/models/response/profile/update_profile_response_dto.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_response_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_vehical_request_entity.dart';
import '../../../../features/profile/data/data_source/update_vehical_info_data_source.dart';

@Injectable(as: UpdateVehicalInfoDataSource)
class UpdateVehicalInfoDataSourceImpl
    implements UpdateVehicalInfoDataSource {
  ApiClient apiClient;

  UpdateVehicalInfoDataSourceImpl(this.apiClient);

  @override
  Future<ApiResult<UpdateProfileResponseEntity>>
  updateVehicalInfo(
      UpdateVehicalRequestEntity request,
      ) async {
    try {
      UpdateProfileResponseDto updateProfileResponseDto =
      await apiClient.editVehical(
        UpdateVehicalRequestDto.fromEntity(request),
      );
      return ApiSuccessResult(
        updateProfileResponseDto.toEntity(),
      );
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData != null &&
            responseData is Map<String, dynamic>) {
          final message =
              responseData["message"] ?? "Unknown error";
          return ApiErrorResult<
              UpdateProfileResponseEntity
          >(message.toString());
        }
        return ApiErrorResult<
            UpdateProfileResponseEntity
        >(e.message ?? e.toString());
      }
      return ApiErrorResult<UpdateProfileResponseEntity>(
        e.toString(),
      );
    }
  }
}
