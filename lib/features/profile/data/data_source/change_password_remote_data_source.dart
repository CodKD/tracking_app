import '../../../../core/api_layer/api_result/api_result.dart';
import '../../../../core/api_layer/models/request/change_password_request_body.dart';
import '../../domain/entities/change_password_entity.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<ApiResult<ChangePasswordEntity>> changPassword(
    ChangePasswordRequestBody body,
  );
}
