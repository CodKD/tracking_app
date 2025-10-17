import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_request_entity.dart';

part 'update_profile_request_dto.g.dart';

@JsonSerializable()
class UpdateProfileRequestDto {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;

  UpdateProfileRequestDto({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  factory UpdateProfileRequestDto.fromJson(
      Map<String, dynamic> json,
      ) {
    return _$UpdateProfileRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateProfileRequestDtoToJson(this);
  }

  UpdateProfileRequestEntity toEntity() {
    UpdateProfileRequestEntity
    updateProfileRequestEntity =
    UpdateProfileRequestEntity(
      phone: phone,
      lastName: lastName,
      firstName: firstName,
      email: email,
    );
    return updateProfileRequestEntity;
  }

  factory UpdateProfileRequestDto.fromEntity(
      UpdateProfileRequestEntity updateProfileRequestEntity,
      ) {
    return UpdateProfileRequestDto(
      phone: updateProfileRequestEntity.phone,
      lastName: updateProfileRequestEntity.lastName,
      firstName: updateProfileRequestEntity.firstName,
      email: updateProfileRequestEntity.email,
    );
  }
}
