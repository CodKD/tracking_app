import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/models/request/auth/apply_request.dart';
import 'package:tracking_app/features/auth/apply/data/data_source/contract/apply_data_source.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/apply_entity.dart';
import 'package:tracking_app/features/auth/apply/domain/repositories/apply_repository.dart';

@Injectable(as: ApplyRepository)
class ApplyRepoImpl implements ApplyRepository {
  final ApplyDataSource applyDataSource;

  ApplyRepoImpl(this.applyDataSource);

  @override
  Future<ApiResult<DriverEntity>> apply(ApplyRequest applyRequest) async {
    return await applyDataSource.apply(applyRequest);
  }
}
