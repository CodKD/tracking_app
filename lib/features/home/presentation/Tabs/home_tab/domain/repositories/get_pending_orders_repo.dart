import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';

abstract class GetPendingOrdersRepo {
    Future<ApiResult<PendingDriverOrdersEntity>> getPendingDriverOrders();
}