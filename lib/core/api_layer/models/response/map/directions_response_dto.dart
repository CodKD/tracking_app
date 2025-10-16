import 'package:json_annotation/json_annotation.dart';

part 'directions_response_dto.g.dart';

@JsonSerializable()
class DirectionsResponseDto {
  @JsonKey(name: 'routes')
  final List<RouteDto>? routes;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'error_message')
  final String? errorMessage;

  DirectionsResponseDto({
    this.routes,
    this.status,
    this.errorMessage,
  });

  factory DirectionsResponseDto.fromJson(
    Map<String, dynamic> json,
  ) => _$DirectionsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DirectionsResponseDtoToJson(this);
}

@JsonSerializable()
class RouteDto {
  @JsonKey(name: 'overview_polyline')
  final PolylineDto? overviewPolyline;

  @JsonKey(name: 'legs')
  final List<LegDto>? legs;

  @JsonKey(name: 'summary')
  final String? summary;

  RouteDto({
    this.overviewPolyline,
    this.legs,
    this.summary,
  });

  factory RouteDto.fromJson(Map<String, dynamic> json) =>
      _$RouteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RouteDtoToJson(this);
}

@JsonSerializable()
class PolylineDto {
  @JsonKey(name: 'points')
  final String? points;

  PolylineDto({this.points});

  factory PolylineDto.fromJson(
    Map<String, dynamic> json,
  ) => _$PolylineDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PolylineDtoToJson(this);
}

@JsonSerializable()
class LegDto {
  @JsonKey(name: 'distance')
  final DistanceDto? distance;

  @JsonKey(name: 'duration')
  final DurationDto? duration;

  @JsonKey(name: 'start_address')
  final String? startAddress;

  @JsonKey(name: 'end_address')
  final String? endAddress;

  LegDto({
    this.distance,
    this.duration,
    this.startAddress,
    this.endAddress,
  });

  factory LegDto.fromJson(Map<String, dynamic> json) =>
      _$LegDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LegDtoToJson(this);
}

@JsonSerializable()
class DistanceDto {
  @JsonKey(name: 'text')
  final String? text;

  @JsonKey(name: 'value')
  final int? value; // in meters

  DistanceDto({this.text, this.value});

  factory DistanceDto.fromJson(
    Map<String, dynamic> json,
  ) => _$DistanceDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DistanceDtoToJson(this);
}

@JsonSerializable()
class DurationDto {
  @JsonKey(name: 'text')
  final String? text;

  @JsonKey(name: 'value')
  final int? value; // in seconds

  DurationDto({this.text, this.value});

  factory DurationDto.fromJson(
    Map<String, dynamic> json,
  ) => _$DurationDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DurationDtoToJson(this);
}