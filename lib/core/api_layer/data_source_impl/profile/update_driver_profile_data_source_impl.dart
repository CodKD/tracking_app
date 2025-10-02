import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/models/request/update_profile_request_dto.dart';
import 'package:tracking_app/core/api_layer/models/response/profile/update_photo_response_dto.dart';
import 'package:tracking_app/core/api_layer/models/response/profile/update_profile_response_dto.dart';
import 'package:tracking_app/features/profile/data/data_source/update_driver_profile_data_source.dart';
import 'package:tracking_app/features/profile/domain/entities/update_photo_response_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_request_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_response_entity.dart';

@Injectable(as: UpdateDriverProfileDataSource)
class UpdateDriverProfileDataSourceImpl
    implements UpdateDriverProfileDataSource {
  ApiClient apiClient;

  UpdateDriverProfileDataSourceImpl(this.apiClient);

  @override
  Future<ApiResult<UpdateProfileResponseEntity>> updateDriverProfile(
    UpdateProfileRequestEntity request,
  ) async {
    try {
      UpdateProfileResponseDto updateProfileResponseDto = await apiClient
          .editProfile(UpdateProfileRequestDto.fromEntity(request));
      return ApiSuccessResult(updateProfileResponseDto.toEntity());
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          final message = responseData["message"] ?? "Unknown error";
          return ApiErrorResult<UpdateProfileResponseEntity>(
            message.toString(),
          );
        }
        return ApiErrorResult<UpdateProfileResponseEntity>(
          e.message ?? e.toString(),
        );
      }
      return ApiErrorResult<UpdateProfileResponseEntity>(e.toString());
    }
  }

  @override
  Future<ApiResult<UpdatePhotoResponseEntity>> updateDriverPhoto(
    File photo,
  ) async {
    try {
      UpdatePhotoResponseDto updatePhotoResponseDto = await apiClient
          .changePhoto(photo);
      return ApiSuccessResult(updatePhotoResponseDto.toEntity());
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          final message = responseData["message"] ?? "Unknown error";
          return ApiErrorResult<UpdatePhotoResponseEntity>(message.toString());
        }
        return ApiErrorResult<UpdatePhotoResponseEntity>(
          e.message ?? e.toString(),
        );
      }
      return ApiErrorResult<UpdatePhotoResponseEntity>(e.toString());
    }
  }
}
