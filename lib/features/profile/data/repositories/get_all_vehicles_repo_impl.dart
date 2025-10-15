import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/models/response/profile/all_vehical_response.dart';
import 'package:tracking_app/features/profile/data/data_source/get_all_vehicles_data_source.dart';
import 'package:tracking_app/features/profile/domain/repositories/get_all_vehicles_repo.dart';

@Injectable(as: GetAllVehiclesRepo)
class GetAllVehiclesRepoImpl
    implements GetAllVehiclesRepo {
  final GetAllVehiclesDataSource getAllVehiclesDataSource;

  GetAllVehiclesRepoImpl({
    required this.getAllVehiclesDataSource,
  });

  @override
  Future<AllVehicalResponse> getAllVehicles() async {
    return await getAllVehiclesDataSource
        .getAllVehicles();
  }
}
