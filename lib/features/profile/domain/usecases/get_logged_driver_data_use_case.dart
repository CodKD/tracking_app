import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:tracking_app/features/profile/domain/repositories/get_logged_driver_data_repo.dart';

@injectable
class GetLoggedDriverDataUseCase {
  GetLoggedDriverDataRepo getLoggedDriverDataRepo;

  GetLoggedDriverDataUseCase(
    this.getLoggedDriverDataRepo,
  );

  Future<ApiResult<ProfileDriverEntity>> call() async {
    final result = await getLoggedDriverDataRepo
        .getLoggedDriverData();
    return result;
  }
}
