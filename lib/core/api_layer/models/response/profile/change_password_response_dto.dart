import 'package:json_annotation/json_annotation.dart';

import '../../../../../features/profile/domain/entities/change_password_entity.dart';

part 'change_password_response_dto.g.dart';

@JsonSerializable()
class ChangePasswordResponseDto {
  final String? message;
  final String? token;

  ChangePasswordResponseDto(this.message, this.token);

  factory ChangePasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseDtoToJson(this);

  ChangePasswordEntity toEntity() {
    return ChangePasswordEntity(message: message, token: token);
  }
}
