import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class PickUpLocationStates {}

class PickUpLocationInitial
    extends PickUpLocationStates {}

class PickUpLocationLoading
    extends PickUpLocationStates {}

class PickUpLocationSuccess extends PickUpLocationStates {
  final LatLng driverLocation;
  final LatLng floweryLocation;
  final List<LatLng> routePoints;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final String distance;
  final String duration;

  PickUpLocationSuccess({
    required this.driverLocation,
    required this.floweryLocation,
    required this.routePoints,
    required this.markers,
    required this.polylines,
    required this.distance,
    required this.duration,
  });
}

class PickUpLocationError extends PickUpLocationStates {
  final String error;
  PickUpLocationError(this.error);
}

class LocationPermissionDenied
    extends PickUpLocationStates {}

class LocationServiceDisabled
    extends PickUpLocationStates {}
