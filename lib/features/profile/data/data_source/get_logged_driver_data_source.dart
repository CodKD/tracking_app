import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';

import '../../../../core/api_layer/api_result/api_result.dart';

abstract class GetLoggedDriverDataSource {
  Future<ApiResult<ProfileDriverEntity>> getLoggedDriverData();
}
