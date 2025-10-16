import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/profile/data/data_source/update_driver_profile_data_source.dart';
import 'package:tracking_app/features/profile/domain/entities/update_photo_response_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_request_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_response_entity.dart';
import 'package:tracking_app/features/profile/domain/repositories/update_profile_repo.dart';

@Injectable(as: UpdateProfileRepo)
class UpdateProfileRepoImpl implements UpdateProfileRepo {
  UpdateDriverProfileDataSource
  updateDriverProfileDataSource;

  UpdateProfileRepoImpl(
    this.updateDriverProfileDataSource,
  );

  @override
  Future<ApiResult<UpdateProfileResponseEntity>>
  updateDriverProfile(
    UpdateProfileRequestEntity updateProfileRequestEntity,
  ) async {
    return await updateDriverProfileDataSource
        .updateDriverProfile(updateProfileRequestEntity);
  }

  @override
  Future<ApiResult<UpdatePhotoResponseEntity>>
  updateDriverPhoto(File photo) async {
    return await updateDriverProfileDataSource
        .updateDriverPhoto(photo);
  }
}
