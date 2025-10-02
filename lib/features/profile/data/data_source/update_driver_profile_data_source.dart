import 'dart:io';

import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/profile/domain/entities/update_photo_response_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_request_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_response_entity.dart';

abstract class UpdateDriverProfileDataSource {
  Future<ApiResult<UpdateProfileResponseEntity>> updateDriverProfile(
    UpdateProfileRequestEntity updateProfileRequestEntity,
  );

  Future<ApiResult<UpdatePhotoResponseEntity>> updateDriverPhoto(File photo);
}
