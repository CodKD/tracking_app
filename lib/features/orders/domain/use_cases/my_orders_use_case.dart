
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/orders/domain/entities/my_orders_entity.dart';
import 'package:tracking_app/features/orders/domain/repositories/my_orders_repo.dart';


@injectable
class MyOrdersUseCase {
  final MyOrdersRepo myOrdersRepo;

  MyOrdersUseCase(this.myOrdersRepo);

  Future<ApiResult<MyOrdersEntity>> getMyOrders() {
    return myOrdersRepo.getMyOrders();
  }
}
