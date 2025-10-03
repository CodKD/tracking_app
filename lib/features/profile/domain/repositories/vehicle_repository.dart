import '../../../../core/api_layer/api_result/api_result.dart';
import '../entities/vehicle.dart';

abstract class VehicleRepository {
  Future<ApiResult<VehicleEntity>> getVehicleInfo();
  Future<ApiResult<VehicleEntity>> updateVehicleInfo(VehicleEntity vehicle);
}
