// dart format width=58

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFilesGen {
  const $AssetsFilesGen();

  /// File path: assets/files/countries.json
  String get countries => 'assets/files/countries.json';

  /// List of all assets
  List<String> get values => [countries];
}

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/home_icon.png
  AssetGenImage get homeIcon =>
      const AssetGenImage('assets/icon/home_icon.png');

  /// File path: assets/icon/order_icon.png
  AssetGenImage get orderIcon =>
      const AssetGenImage('assets/icon/order_icon.png');

  /// File path: assets/icon/profile_icon.png
  AssetGenImage get profileIcon =>
      const AssetGenImage('assets/icon/profile_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    homeIcon,
    orderIcon,
    profileIcon,
  ];
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/no_routes.png
  AssetGenImage get noRoutes =>
      const AssetGenImage('assets/image/no_routes.png');

  /// File path: assets/image/onboarding.png
  AssetGenImage get onboarding =>
      const AssetGenImage('assets/image/onboarding.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    noRoutes,
    onboarding,
  ];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/Vector.svg
  String get vector => 'assets/svg/Vector.svg';

  /// File path: assets/svg/bg.svg
  String get bg => 'assets/svg/bg.svg';

  /// File path: assets/svg/call.svg
  String get call => 'assets/svg/call.svg';

  /// File path: assets/svg/location.svg
  String get location => 'assets/svg/location.svg';

  /// File path: assets/svg/orderSuccessfullyIcon.svg
  String get orderSuccessfullyIcon =>
      'assets/svg/orderSuccessfullyIcon.svg';

  /// File path: assets/svg/orders.svg
  String get orders => 'assets/svg/orders.svg';

  /// File path: assets/svg/whatsapp.svg
  String get whatsapp => 'assets/svg/whatsapp.svg';

  /// List of all assets
  List<String> get values => [
    vector,
    bg,
    call,
    location,
    orderSuccessfullyIcon,
    orders,
    whatsapp,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsFilesGen files = $AssetsFilesGen();
  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImageGen image = $AssetsImageGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
