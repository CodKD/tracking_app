import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Utility class to convert assets to BitmapDescriptor for Google Maps markers
class SvgToIcon {
  static Future<BitmapDescriptor> fromPngAsset(
    String assetPath, {
    int width = 80,
    double imageScale =
        3.0, // Default to 3x for better quality
  }) async {
    try {
      final ByteData data = await rootBundle.load(
        assetPath,
      );
      final Uint8List bytes = data.buffer.asUint8List();

      // Calculate target width for high quality rendering
      // Use larger size during decoding, then scale down for display
      final int targetWidth = (width * imageScale)
          .toInt();

      // Decode image with high quality settings
      final ui.Codec
      codec = await ui.instantiateImageCodec(
        bytes,
        targetWidth: targetWidth,
        allowUpscaling:
            false, // Don't upscale - maintains quality
      );
      final ui.FrameInfo frameInfo = await codec
          .getNextFrame();

      // Convert to bytes with PNG format (lossless, best quality)
      final ByteData? byteData = await frameInfo.image
          .toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception(
          'Failed to convert image to bytes',
        );
      }

      final Uint8List resizedBytes = byteData.buffer
          .asUint8List();

      return BitmapDescriptor.bytes(
        resizedBytes,
        width: width
            .toDouble(), // Final display size on map
        height: width.toDouble(),
      );
    } catch (e) {
      return BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      );
    }
  }

  /// Creates a custom colored marker icon
}
