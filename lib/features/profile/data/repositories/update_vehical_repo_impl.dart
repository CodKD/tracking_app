import 'package:injectable/injectable.dart';
import 'package:tracking_app/features/profile/data/data_source/update_vehical_info_data_source.dart';
import 'package:tracking_app/features/profile/domain/entities/update_vehical_request_entity.dart';
import '../../../../core/api_layer/api_result/api_result.dart';
import '../../domain/entities/update_profile_response_entity.dart';
import '../../domain/repositories/update_vehical_repo.dart';

@Injectable(as: UpdateVehicalRepo)
class UpdateVehicalRepoImpl implements UpdateVehicalRepo {
  UpdateVehicalInfoDataSource updateVehicalInfoDataSource;

  UpdateVehicalRepoImpl(this.updateVehicalInfoDataSource);

  @override
  Future<ApiResult<UpdateProfileResponseEntity>>
  updateVehicalInfo(
    UpdateVehicalRequestEntity updateVehicalRequestEntity,
  ) async {
    return await updateVehicalInfoDataSource
        .updateVehicalInfo(updateVehicalRequestEntity);
  }
}
