import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/login/domain/entities/login_response_entity.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  @JsonKey(name: "error")
  final String? error;

  LoginResponseDto ({
    this.message,
    this.token,
    this.error,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseDtoToJson(this);
  }

  LoginResponseEntity toEntity() {
    return LoginResponseEntity(
      message: message,
      token: token,
      error: error,
    );
  }
}


