import 'package:tracking_app/features/profile/domain/entities/update_vehical_request_entity.dart';

import '../../../../core/api_layer/api_result/api_result.dart';
import '../entities/update_profile_response_entity.dart';

abstract class UpdateVehicalRepo {
  Future<ApiResult<UpdateProfileResponseEntity>>
  updateVehicalInfo(
      UpdateVehicalRequestEntity updateVehicalRequestEntity,
  );
}
