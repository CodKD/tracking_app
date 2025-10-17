import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/api_layer/api_client/endpoints.dart';
import 'package:tracking_app/core/api_layer/models/response/map/directions_response_dto.dart';

part 'google_maps_api_client.g.dart';

@singleton
@RestApi(baseUrl: Endpoints.googleMapsbaseUrl)
abstract class GoogleMapsApiClient {
  @factoryMethod
  factory GoogleMapsApiClient(Dio dio) =
      _GoogleMapsApiClient;

  /// Get directions between two points
  ///
  /// [origin] - Starting point as "latitude,longitude"
  /// [destination] - Ending point as "latitude,longitude"
  /// [mode] - Travel mode: driving, walking, bicycling, transit
  /// [key] - Google Maps API key
  @GET('directions/json')
  Future<DirectionsResponseDto> getDirections({
    @Query('origin') required String origin,
    @Query('destination') required String destination,
    @Query('mode') String mode = 'driving',
    @Query('key') required String key,
  });
}