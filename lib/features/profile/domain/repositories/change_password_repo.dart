
import '../../../../core/api_layer/api_result/api_result.dart';
import '../../../../core/api_layer/models/request/change_password_request_body.dart';
import '../entities/change_password_entity.dart';

abstract class ChangPasswordRepo {
  Future<ApiResult<ChangePasswordEntity>> changPassword(
    ChangePasswordRequestBody body,
  );
}
