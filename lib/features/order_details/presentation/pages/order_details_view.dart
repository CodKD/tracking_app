
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/core/api_layer/firebase/firestore_manager.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/utils/caching/caching_helper.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/order_delivered_successfully.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/skeleton_order_details.dart';
import '../../data/models/request/update_order_request.dart';
import '../view_model/start_order_cubit.dart';
import '../widgets/order_details_view_body.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({
    super.key,
  });

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {


  late StartOrderCubit viewModel;
  bool isActive = true;

  @override
  void initState() {
    viewModel = getIt.get<StartOrderCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String orderId = CacheService.getData(key: CacheConstants.orderPendingId);
    return BlocProvider(
      create: (context) => viewModel
        ..updateOrder(
            orderId,
            UpdateOrderRequest(
              state: 'inProgress',
            )),
      child: BlocListener<StartOrderCubit, StartOrderState>(
        listener: (context, state) {
          if (state is SuccessUpdateOrderState) {}
          if (state is SuccessStartOrderState) {}
        },
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
               
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        height: 5.0,
                        decoration: BoxDecoration(
                            color: index <= currentStep
                                ? Colors.pink
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  }),
                ),
                FutureBuilder(
                    future:
                        FirebaseUtils.fetchOrderFromFirebase(orderId: orderId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Expanded(child: OrderDetailsSkeleton());
                      } else if (snapshot.hasError) {
                        return Center(
                          child:
                              Center(child: Text('${context.l10n.error} : ${snapshot.error}')),
                        );
                      } else if (snapshot.hasData) {

                        final orderDetails = snapshot.data!;
                        return Expanded(
                          child: OrderDetailsViewBody(
                            orderDetails: orderDetails,
                            status: stateOrder2[currentStep],
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('No data found'),
                        );
                      }
                    }),
                const SizedBox(height: 24),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: currentStep < 4
                      ? () {
                    FirebaseUtils.updateOrderState(
                      orderId,
                      OrderStateModel(
                        state: stateOrder2[currentStep+1],
                        updatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
                      ),
                    );
                    if (currentStep == 0) {
                      UpdateOrderRequest state = UpdateOrderRequest();
                      state.state = 'inProgress';
                      viewModel.startOrder(orderId);
                      FirebaseUtils.updateOrderState(
                        orderId,
                        OrderStateModel(
                          state: stateOrder2[currentStep+1],
                          updatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
                        ),
                      );
                    }

                    if (currentStep == 4) {
                      FirebaseUtils.updateOrderState(
                        orderId,
                        OrderStateModel(
                          state: stateOrder2[currentStep+1],
                          updatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
                        ),
                      );
                      CacheService.deleteItem(key: CacheConstants.currentStep);
                    }

                    setState(() {
                      currentStep++;
                      CacheService.setData(
                        key: CacheConstants.currentStep,
                        value: currentStep,
                      );
                    });
                  }
                      : () async {
                    if (currentStep == 4) {
                      viewModel.updateOrder(orderId, UpdateOrderRequest(state:'completed' ));
                      currentStep = 0;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderDeliveredSuccessfully(),
                        ),
                      );
                    }
                    if (isActive) {
                      setState(() {});
                      isActive = false;
                    } else {
                      orderPendingId = '';
                      viewModel.updateOrder(
                        orderId,
                        UpdateOrderRequest(state: 'completed'),
                      );
                      CacheService.setData(
                        key: CacheConstants.currentStep,
                        value: 0,
                      );

                    }
                  },
                  child: Text(
                    currentStep < 4
                        ? buttonTitle[currentStep]
                        : buttonTitle[4],
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )


              ],
            ),
          ),
        )),
      ),
    );
  }
}

List<String> buttonTitle = [
  'Arrived at Pickup point',
  'Arrived at Pickup point',
  'Start deliver',
  'Arrived to the user',
  'Delivered to the user',
  'Delivered to the user',
];
List<String> stateOrder = ['pending', 'inProgress', 'canceled', 'completed'];
List<String> stateOrder2 = [
  'Accepted',
  'Picked',
  'Out for delivery',
  'Delivered',
  'Arrived'
];
