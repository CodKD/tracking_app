import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/google_maps_api_client.dart';
import 'package:tracking_app/core/map/map_utils.dart';
import 'package:tracking_app/core/utils/svg_to_icon.dart';
import 'package:tracking_app/core/resources/app_constants.dart';
import 'package:tracking_app/features/pick_up_location/presentation/cubit/pick_up_location_states.dart';

@injectable
class PickUpLocationCubit
    extends Cubit<PickUpLocationStates> {
  final GoogleMapsApiClient _googleMapsApiClient;

  PickUpLocationCubit(this._googleMapsApiClient)
    : super(PickUpLocationInitial());

  // Fixed flowery location
  static const LatLng floweryLocation = LatLng(
    31.241263060169246,
    29.967028692169325,
  );

  // Static driver location
  static const LatLng driverLocation = LatLng(
    31.272279,
    30.007319,
  );

  // Static driver location
  static const LatLng userLocation = LatLng(
    31.27082513964296,
    29.994602643902656,
  );

  GoogleMapController? _mapController;

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> initializeLocation(
    bool isUserLocation,
  ) async {
    emit(PickUpLocationLoading());

    try {
      // Use static driver location directly
      await _updateLocationData(
        driverLocation,
        isUserLocation,
      );
    } catch (e) {
      emit(
        PickUpLocationError(
          'Failed to initialize location: $e',
        ),
      );
    }
  }

  Future<void> _updateLocationData(
    LatLng staticDriverLocation,
    bool isUserLocation,
  ) async {
    try {
      // Get route from Google Directions API
      final directionsResponse =
          await _googleMapsApiClient.getDirections(
            origin:
                '${staticDriverLocation.latitude},${staticDriverLocation.longitude}',
            destination: isUserLocation
                ? '${userLocation.latitude},${userLocation.longitude}'
                : '${floweryLocation.latitude},${floweryLocation.longitude}',
            mode: 'driving',
            key: AppConstants.googleMapsApiKey,
          );

      if (directionsResponse.status != 'OK' ||
          directionsResponse.routes == null ||
          directionsResponse.routes!.isEmpty) {
        throw Exception('No route found');
      }

      final route = directionsResponse.routes!.first;
      final leg = route.legs?.first;

      // Decode polyline points
      List<LatLng> routePoints = [];
      if (route.overviewPolyline?.points != null) {
        routePoints = MapUtils.decodePolyline(
          route.overviewPolyline!.points!,
        );
      }

      // Create markers
      Set<Marker> markers = await _createMarkers(
        staticDriverLocation,
        floweryLocation,
        userLocation,
        isUserLocation,
      );

      // Create polylines
      Set<Polyline> polylines = _createPolylines(
        routePoints,
      );

      // Get distance and duration
      String distance = leg?.distance?.text ?? 'Unknown';
      String duration = leg?.duration?.text ?? 'Unknown';

      emit(
        PickUpLocationSuccess(
          driverLocation: staticDriverLocation,
          floweryLocation: floweryLocation,
          routePoints: routePoints,
          markers: markers,
          polylines: polylines,
          distance: distance,
          duration: duration,
        ),
      );

      // Update camera to show both locations
      if (_mapController != null &&
          routePoints.isNotEmpty) {
        _updateCameraToFitRoute([
          staticDriverLocation,
          floweryLocation,
        ]);
      }
    } catch (e) {
      debugPrint('Error updating location data: $e');
      // Fallback to basic markers without route - still show distance and markers
      _createBasicMarkersOnly(
        staticDriverLocation,
        isUserLocation,
      );
    }
  }

  Future<void> _createBasicMarkersOnly(
    LatLng staticDriverLocation,
    bool isUserLocation,
  ) async {
    try {
      Set<Marker> markers = await _createMarkers(
        staticDriverLocation,
        floweryLocation,
        userLocation,
        isUserLocation,
      );

      // Calculate basic distance using Haversine formula
      double distanceInMeters =
          MapUtils.calculateDistance(
            staticDriverLocation.latitude,
            staticDriverLocation.longitude,
            floweryLocation.latitude,
            floweryLocation.longitude,
          );

      String distance = MapUtils.formatDistance(
        distanceInMeters,
      );

      emit(
        PickUpLocationSuccess(
          driverLocation: staticDriverLocation,
          floweryLocation: floweryLocation,
          routePoints: [
            staticDriverLocation,
            floweryLocation,
          ],
          markers: markers,
          polylines: {},
          distance: distance,
          duration: 'Unknown',
        ),
      );

      if (_mapController != null) {
        _updateCameraToFitRoute([
          staticDriverLocation,
          floweryLocation,
        ]);
      }
    } catch (e) {
      emit(
        PickUpLocationError(
          'Failed to create basic markers: $e',
        ),
      );
    }
  }

  Future<Set<Marker>> _createMarkers(
    LatLng staticDriverLocation,
    LatLng floweryLocation,
    LatLng? userLocation,
    bool isUserLocation,
  ) async {
    Set<Marker> markers = {};

    try {
      // Create driver marker with driver icon
      BitmapDescriptor
      driverIcon = await SvgToIcon.fromPngAsset(
        'assets/image/driver_location.png', // Driver icon
        width: 80,
        imageScale: 4,
      );

      markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: staticDriverLocation,
          icon: driverIcon,
          infoWindow: const InfoWindow(
            title: 'Driver Location',
            snippet: 'Current driver position',
          ),
        ),
      );

      // Create second marker based on isUserLocation
      BitmapDescriptor secondIcon =
          await SvgToIcon.fromPngAsset(
            isUserLocation
                ? 'assets/image/user_location.png'
                : 'assets/image/flowery_location.png',
            width: 80,
            imageScale: 4,
          );

      markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: isUserLocation
              ? userLocation!
              : floweryLocation,
          icon: secondIcon,
          infoWindow: InfoWindow(
            title: isUserLocation
                ? 'User Location'
                : 'Flowery Store',
            snippet: isUserLocation
                ? 'Delivery destination'
                : 'Pickup location',
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error creating custom markers: $e');
      // Fallback to default markers
      markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: staticDriverLocation,
          infoWindow: const InfoWindow(
            title: 'Your location',
            snippet: 'Driver position',
          ),
        ),
      );

      markers.add(
        Marker(
          markerId: const MarkerId('flowery'),
          position: isUserLocation
              ? userLocation!
              : floweryLocation,
          infoWindow: InfoWindow(
            title: isUserLocation ? 'User' : 'Flowery',
            snippet: '20th st, Sheikh Zayed, Giza',
          ),
        ),
      );
    }

    return markers;
  }

  Set<Polyline> _createPolylines(
    List<LatLng> routePoints,
  ) {
    if (routePoints.isEmpty) return {};

    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: routePoints,
        color: const Color(
          0xFFD21E6A,
        ), // Pink color from theme
        width: 4,
        patterns: [],
      ),
    };
  }

  void _updateCameraToFitRoute(List<LatLng> locations) {
    if (locations.isEmpty || _mapController == null) {
      return;
    }

    try {
      LatLngBounds bounds = MapUtils.calculateBounds(
        locations,
      );

      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(
          bounds,
          100.0, // padding
        ),
      );
    } catch (e) {
      debugPrint('Error updating camera: $e');
    }
  }

  Future<void> requestLocationPermission(
    bool isUserLocation,
  ) async {
    await initializeLocation(isUserLocation);
  }

  Future<void> enableLocationService(
    bool isUserLocation,
  ) async {
    await initializeLocation(isUserLocation);
  }
}
