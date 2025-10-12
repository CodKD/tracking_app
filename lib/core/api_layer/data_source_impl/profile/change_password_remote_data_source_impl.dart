import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../features/profile/data/data_source/change_password_remote_data_source.dart';
import '../../../../features/profile/domain/entities/change_password_entity.dart';
import '../../api_client/api_client.dart';
import '../../api_result/api_result.dart';
import '../../models/request/change_password_request_body.dart';
import '../../models/response/profile/change_password_response_dto.dart';

@Injectable(as: ChangePasswordRemoteDataSource)
class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  ApiClient apiClient;

  ChangePasswordRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ApiResult<ChangePasswordEntity>> changPassword(
    ChangePasswordRequestBody body,
  ) async {
    try {
      ChangePasswordResponseDto changePasswordResponseDto = await apiClient
          .changePassword(body);
      return ApiSuccessResult(changePasswordResponseDto.toEntity());
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          final message = responseData["message"] ?? "Unknown error";
          return ApiErrorResult<ChangePasswordEntity>(message.toString());
        }
        return ApiErrorResult<ChangePasswordEntity>(e.message ?? e.toString());
      }
      return ApiErrorResult<ChangePasswordEntity>(e.toString());
    }
  }
}
