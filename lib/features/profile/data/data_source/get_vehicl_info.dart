import 'package:tracking_app/features/profile/domain/entities/vehicle.dart';

import '../../../../core/api_layer/api_result/api_result.dart';
import '../../domain/entities/get_logged_driver_entity.dart';

abstract class GetVehicleInfo {
  Future<ApiResult<ProfileDriverEntity>> getLoggedDriverData();

  Future<ApiResult<VehicleEntity>> getVehicleInfo();}
