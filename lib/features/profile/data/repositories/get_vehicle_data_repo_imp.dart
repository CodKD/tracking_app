import '../../../../core/api_layer/api_result/api_result.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../data_source/get_vehicl_info.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final GetVehicleInfo _getVehicleInfo;

  VehicleRepositoryImpl(this._getVehicleInfo);

  @override
  Future<ApiResult<VehicleEntity>> getVehicleInfo() async {
    return await _getVehicleInfo.getVehicleInfo();
  }
  @override
  Future<ApiResult<VehicleEntity>> updateVehicleInfo(VehicleEntity vehicle) async {
    throw UnimplementedError();
  }
}