import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_response_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_vehical_request_entity.dart';
import 'package:tracking_app/features/profile/domain/repositories/update_vehical_repo.dart';

@injectable
class UpdateVehicalUseCase {
  UpdateVehicalRepo updateVehicalRepo;

  UpdateVehicalUseCase(this.updateVehicalRepo);

  Future<ApiResult<UpdateProfileResponseEntity>> invoke(
    UpdateVehicalRequestEntity updateProfileRequestEntity,
  ) async {
    return await updateVehicalRepo.updateVehicalInfo(
      updateProfileRequestEntity,
    );
  }
}
