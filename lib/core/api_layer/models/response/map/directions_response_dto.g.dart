// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directions_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectionsResponseDto _$DirectionsResponseDtoFromJson(
  Map<String, dynamic> json,
) => DirectionsResponseDto(
  routes: (json['routes'] as List<dynamic>?)
      ?.map((e) => RouteDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  status: json['status'] as String?,
  errorMessage: json['error_message'] as String?,
);

Map<String, dynamic> _$DirectionsResponseDtoToJson(
  DirectionsResponseDto instance,
) => <String, dynamic>{
  'routes': instance.routes,
  'status': instance.status,
  'error_message': instance.errorMessage,
};

RouteDto _$RouteDtoFromJson(Map<String, dynamic> json) => RouteDto(
  overviewPolyline: json['overview_polyline'] == null
      ? null
      : PolylineDto.fromJson(json['overview_polyline'] as Map<String, dynamic>),
  legs: (json['legs'] as List<dynamic>?)
      ?.map((e) => LegDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  summary: json['summary'] as String?,
);

Map<String, dynamic> _$RouteDtoToJson(RouteDto instance) => <String, dynamic>{
  'overview_polyline': instance.overviewPolyline,
  'legs': instance.legs,
  'summary': instance.summary,
};

PolylineDto _$PolylineDtoFromJson(Map<String, dynamic> json) =>
    PolylineDto(points: json['points'] as String?);

Map<String, dynamic> _$PolylineDtoToJson(PolylineDto instance) =>
    <String, dynamic>{'points': instance.points};

LegDto _$LegDtoFromJson(Map<String, dynamic> json) => LegDto(
  distance: json['distance'] == null
      ? null
      : DistanceDto.fromJson(json['distance'] as Map<String, dynamic>),
  duration: json['duration'] == null
      ? null
      : DurationDto.fromJson(json['duration'] as Map<String, dynamic>),
  startAddress: json['start_address'] as String?,
  endAddress: json['end_address'] as String?,
);

Map<String, dynamic> _$LegDtoToJson(LegDto instance) => <String, dynamic>{
  'distance': instance.distance,
  'duration': instance.duration,
  'start_address': instance.startAddress,
  'end_address': instance.endAddress,
};

DistanceDto _$DistanceDtoFromJson(Map<String, dynamic> json) => DistanceDto(
  text: json['text'] as String?,
  value: (json['value'] as num?)?.toInt(),
);

Map<String, dynamic> _$DistanceDtoToJson(DistanceDto instance) =>
    <String, dynamic>{'text': instance.text, 'value': instance.value};

DurationDto _$DurationDtoFromJson(Map<String, dynamic> json) => DurationDto(
  text: json['text'] as String?,
  value: (json['value'] as num?)?.toInt(),
);

Map<String, dynamic> _$DurationDtoToJson(DurationDto instance) =>
    <String, dynamic>{'text': instance.text, 'value': instance.value};
