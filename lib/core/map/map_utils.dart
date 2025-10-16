import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Utility class for map-related calculations and operations
class MapUtils {
  MapUtils._(); // Private constructor to prevent instantiation

  /// Calculate distance between two points using Haversine formula
  /// Returns distance in meters
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371000; // meters
    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);

    final double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  /// Calculate bearing/heading angle between two points
  /// Returns angle in degrees (0-360)
  static double calculateBearing(
    LatLng start,
    LatLng end,
  ) {
    final double startLat = _toRadians(start.latitude);
    final double startLng = _toRadians(start.longitude);
    final double endLat = _toRadians(end.latitude);
    final double endLng = _toRadians(end.longitude);

    final double dLng = endLng - startLng;

    final double y = sin(dLng) * cos(endLat);
    final double x =
        cos(startLat) * sin(endLat) -
        sin(startLat) * cos(endLat) * cos(dLng);

    // Calculate angle in radians then convert to degrees
    double bearing = atan2(y, x);
    bearing = bearing * 180 / pi;

    // Convert result to be between 0-360 degrees
    return (bearing + 360) % 360;
  }

  /// Decode Google Maps encoded polyline string to list of LatLng points
  static List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0
          ? ~(result >> 1)
          : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0
          ? ~(result >> 1)
          : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  /// Calculate bounds that fit all given locations
  static LatLngBounds calculateBounds(
    List<LatLng> locations,
  ) {
    if (locations.isEmpty) {
      throw ArgumentError(
        'Locations list cannot be empty',
      );
    }

    double minLat = locations.first.latitude;
    double maxLat = locations.first.latitude;
    double minLng = locations.first.longitude;
    double maxLng = locations.first.longitude;

    for (var location in locations) {
      if (location.latitude < minLat) {
        minLat = location.latitude;
      }
      if (location.latitude > maxLat) {
        maxLat = location.latitude;
      }
      if (location.longitude < minLng) {
        minLng = location.longitude;
      }
      if (location.longitude > maxLng) {
        maxLng = location.longitude;
      }
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  /// Convert degrees to radians
  static double _toRadians(double degrees) {
    return degrees * pi / 180;
  }

  /// Convert radians to degrees
  static double toDegrees(double radians) {
    return radians * 180 / pi;
  }

  /// Format distance for display
  /// Returns formatted string like "1.5 km" or "250 m"
  static String formatDistance(double meters) {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    } else {
      return '${meters.toStringAsFixed(0)} m';
    }
  }
}
