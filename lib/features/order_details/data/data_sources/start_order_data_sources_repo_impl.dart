
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/order_details/data/models/request/update_order_request.dart';
import 'package:tracking_app/features/order_details/domain/entities/update_order_state_entity.dart';

import 'start_order_data_sources_repo.dart';
import '../../domain/entities/start_order_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderDetailsDataSourcesRepo)
class StartOrderDataSourcesRepoImpl implements OrderDetailsDataSourcesRepo {
  ApiClient apiService;

  StartOrderDataSourcesRepoImpl(this.apiService);

  @override
  Future<ApiResult<StartOrderEntity?>> startOrder(String orderId)async {


    try {
      var response = await apiService.startOrder(orderId);
      
      return ApiSuccessResult(response?.toStartOrderEntity());
    } catch (e) {
      return ApiErrorResult(e.toString());
    }
  }

  @override
  Future<ApiResult<UpdateOrderStateEntity?>> updateOrder( String orderId,UpdateOrderRequest updateOrderRequest) async{
    try {
      var response = await apiService.updateOrder(orderId,updateOrderRequest);
      
      return ApiSuccessResult(response?.toUpdateOrderStateEntity());
    } catch (e) {
      return ApiErrorResult(e.toString());
    }
  }
}
