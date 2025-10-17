import 'package:json_annotation/json_annotation.dart';

part 'all_vehical_response.g.dart';

@JsonSerializable()
class AllVehicalResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "vehicles")
  final List<Vehicles>? vehicles;

  AllVehicalResponse ({
    this.message,
    this.metadata,
    this.vehicles,
  });

  factory AllVehicalResponse.fromJson(Map<String, dynamic> json) {
    return _$AllVehicalResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllVehicalResponseToJson(this);
  }
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  Metadata ({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetadataToJson(this);
  }
}

@JsonSerializable()
class Vehicles {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? V;

  Vehicles ({
    this.id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.V,
  });

  factory Vehicles.fromJson(Map<String, dynamic> json) {
    return _$VehiclesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VehiclesToJson(this);
  }
}


