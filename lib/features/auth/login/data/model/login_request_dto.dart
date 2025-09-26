import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/auth/login/domain/entities/login_request_entity.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDto {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;

  LoginRequestDto ({
    this.email,
    this.password,
  });

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) {
    return _$LoginRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginRequestDtoToJson(this);
  }


  LoginRequestEntity toEntity() {
    return LoginRequestEntity(
      email: email,
      password: password,
    );
  }
}