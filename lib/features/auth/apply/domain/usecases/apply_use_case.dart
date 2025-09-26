import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/models/request/auth/apply_request.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/apply_entity.dart';
import 'package:tracking_app/features/auth/apply/domain/repositories/apply_repository.dart';

@injectable
class ApplyUseCase {
  final ApplyRepository applyRepo;

  ApplyUseCase(this.applyRepo);

  Future<ApiResult<DriverEntity>> call(ApplyRequest applyRequest) async {
    final result = await applyRepo.apply(applyRequest);
    return result;
  }
}
