import 'package:tracking_app/features/profile/domain/entities/vehicle.dart';

import '../../../../core/api_layer/api_result/api_result.dart';
import '../repositories/vehicle_repository.dart';

class UpdateVehicleInfoUseCase {
  VehicleRepository vehicleRepository;

  UpdateVehicleInfoUseCase(this.vehicleRepository);

  Future<ApiResult<VehicleEntity>> call() async {
    final result = await vehicleRepository.getVehicleInfo();
    return result;
  }
}
