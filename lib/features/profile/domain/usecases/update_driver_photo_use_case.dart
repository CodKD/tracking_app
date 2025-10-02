import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/profile/domain/entities/update_photo_response_entity.dart';
import 'package:tracking_app/features/profile/domain/repositories/update_profile_repo.dart';

@injectable
class UpdateDriverPhotoUseCase {
  UpdateProfileRepo updateProfileRepo;

  UpdateDriverPhotoUseCase(this.updateProfileRepo);

  Future<ApiResult<UpdatePhotoResponseEntity>> invoke(File photo) async {
    return await updateProfileRepo.updateDriverPhoto(photo);
  }
}
