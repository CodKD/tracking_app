import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';

abstract class GetLoggedDriverDataRepo {
  Future<ApiResult<ProfileDriverEntity>> getLoggedDriverData();
}
