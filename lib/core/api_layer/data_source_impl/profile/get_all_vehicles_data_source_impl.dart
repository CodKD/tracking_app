import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/features/profile/data/data_source/get_all_Vehicles_data_source.dart';

import '../../models/response/profile/all_vehical_response.dart';

@Injectable(as: GetAllVehiclesDataSource)
class GetAllVehiclesDataSourceImpl
    implements GetAllVehiclesDataSource {
  final ApiClient apiClient;

  GetAllVehiclesDataSourceImpl({required this.apiClient});

  @override
  Future<AllVehicalResponse> getAllVehicles() async {
    try {
      final response = await apiClient.getAllVehicles();
      return response;
    } catch (e) {
      throw Exception('Error fetching vehicles: $e');
    }
  }
}
