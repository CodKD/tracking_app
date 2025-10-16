import '../../../../core/api_layer/models/response/profile/all_vehical_response.dart';

abstract class GetAllVehiclesRepo {
  Future<AllVehicalResponse> getAllVehicles();
}
