import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/models/response/profile/all_vehical_response.dart';
import 'package:tracking_app/features/profile/domain/repositories/get_all_vehicles_repo.dart';

@injectable
class GetAllVehiclesUseCase {
  GetAllVehiclesRepo getAllVehiclesRepo;

  GetAllVehiclesUseCase({
    required this.getAllVehiclesRepo,
  });

  Future<AllVehicalResponse> call() async {
    final result = await getAllVehiclesRepo
        .getAllVehicles();
    return result;
  }
}
