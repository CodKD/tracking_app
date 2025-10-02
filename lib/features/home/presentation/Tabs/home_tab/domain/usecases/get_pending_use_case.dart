import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/repositories/get_pending_orders_repo.dart';

@injectable
class GetPendingOrdersUseCase { 
  final GetPendingOrdersRepo repository;

  GetPendingOrdersUseCase(this.repository);

  Future<ApiResult<PendingDriverOrdersEntity>> call()async {
    final result = await repository.getPendingDriverOrders();
    return result;
  }
}