import 'package:tracking_app/core/api_layer/models/response/profile/all_vehical_response.dart';

abstract class GetAllVehiclesDataSource {
  Future<AllVehicalResponse> getAllVehicles();
}
