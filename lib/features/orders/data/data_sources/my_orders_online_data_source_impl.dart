import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/orders/domain/entities/my_orders_entity.dart';
import 'my_orders_online_data_source.dart';

@Injectable(as: MyOrdersOnlineDataSource)
class MyOrdersOnlineDataSourceImpl implements MyOrdersOnlineDataSource {
  ApiClient apiService;

  MyOrdersOnlineDataSourceImpl(this.apiService);

  @override
  Future<ApiResult<MyOrdersEntity>> getMyOrders()async {
   try {
      var response = await apiService.getMyOrders();
      return ApiSuccessResult(response.toMyOrdersEntity());
   } catch (e) {
     
      return ApiErrorResult(e.toString());
   }
  }
}
