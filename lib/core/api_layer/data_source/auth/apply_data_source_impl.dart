import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/models/request/auth/apply_request.dart';
import 'package:tracking_app/core/api_layer/models/response/auth/apply_response.dart';
import 'package:tracking_app/core/di/modules/shared_preferences_module.dart';
import 'package:tracking_app/core/errors/failures.dart';
import 'package:tracking_app/core/keys/shared_key.dart';
import 'package:tracking_app/features/auth/apply/data/data_source/apply_data_source.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/apply_entity.dart';

@Injectable(as: ApplyDataSource)
class ApplyDataSourceImpl implements ApplyDataSource {
  final ApiClient apiClient;

  ApplyDataSourceImpl(this.apiClient);

  @override
  Future<ApiResult<DriverEntity>> apply(ApplyRequest applyRequest) async {
    ApplyResponse? applyResponse;
    try {
      applyResponse = await apiClient.apply(
        applyRequest.email ?? '',
        applyRequest.password ?? '',
        applyRequest.rePassword ?? '',
        applyRequest.firstName ?? '',
        applyRequest.lastName ?? '',
        applyRequest.phone ?? '',
        applyRequest.gender ?? '',
        applyRequest.NID ?? '',
        applyRequest.vehicleType ?? '',
        applyRequest.vehicleNumber ?? '',
        applyRequest.country ?? '',
        applyRequest.vehicleLicense,
        applyRequest.NIDImg,
      );
      if (applyResponse.token != null) {
        await SharedPrefHelper().setString(
          key: SharedPrefKeys.tokenKey,
          stringValue: applyResponse.token!,
        );
      }
      if (applyResponse.token!.isEmpty) {
        throw ServerError(errorMessage: "Invalid credentials");
      }

      return ApiSuccessResult(applyResponse.driver!.toApplyEntity());
    } catch (e) {
      return ApiErrorResult<DriverEntity>(applyResponse!.error ?? e.toString());
    }
  }
}
