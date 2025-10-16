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

import '../../../../core/api_layer/api_result/api_result.dart';
import '../../domain/entities/update_profile_request_entity.dart';
import '../../domain/entities/update_profile_response_entity.dart';
import '../../domain/repositories/update_vehical_repo.dart';
import '../data_source/update_driver_profile_data_source.dart';

@Injectable(as: UpdateVehicalRepo)
class UpdateVehicalRepoImpl implements UpdateVehicalRepo {
  UpdateDriverProfileDataSource
  updateDriverProfileDataSource;

  UpdateVehicalRepoImpl(
    this.updateDriverProfileDataSource,
  );

  @override
  Future<ApiResult<UpdateProfileResponseEntity>>
  updateVehicalInfo(
    UpdateVehicalRequestEntity updateVehicalRequestEntity,
  ) async {
    return await updateVehicalInfoDataSource
        .updateVehicalInfo(updateVehicalRequestEntity);
    UpdateProfileRequestEntity updateProfileRequestEntity,
  ) async {
    return await updateDriverProfileDataSource
        .updateDriverProfile(updateProfileRequestEntity);
  }
}
