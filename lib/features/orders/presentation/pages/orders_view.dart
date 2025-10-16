import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/skeleton_home.dart';
import 'package:tracking_app/features/orders/domain/entities/my_orders_entity.dart';
import 'package:tracking_app/features/orders/presentation/manager/my_orders_view_model.dart';
import 'package:tracking_app/features/orders/presentation/widgets/my_orders_card.dart';
import '../../../../core/di/di.dart';
import '../../data/models/my_orders_response.dart';
import '../manager/my_orders_state.dart';
import '../widgets/my_order_details_view.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  late MyOrdersViewModel viewModel;
  late List<Orders> ordersViewed;
  int completedOrders = 0;
  int cancelledOrders = 0;

  @override
  void initState() {
    viewModel = getIt<MyOrdersViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: Colors.pink,
      onRefresh: () {
        return viewModel.getMyOrders();
      },
      child: BlocProvider(
        create: (context) => viewModel..getMyOrders(),
        child:  SafeArea(
            child: Column(
              children: [
               
                const SizedBox(
                  height: 24,
                ),
                BlocBuilder<MyOrdersViewModel, MyOrdersState>(
                    builder: (context, state) {
                  if (state is MyOrdersLoading) {
                    return const Expanded(child: SkeletonHome());
                  } else if (state is MyOrdersSuccess) {
                    MyOrdersEntity myOrdersEntity = state.myOrdersEntity;
                    List<Orders> orders = myOrdersEntity.orders ?? [];
                    debugPrint("============================");
                    debugPrint(orders.length.toString());
                    int index = orders.length;
                    for (int i = 0; i < index; i++) {
                      if (orders[i].order?.state == 'completed') {
                        completedOrders++;
                        debugPrint("======================$completedOrders");
                      }
                    }
                    int count = orders.length;
            
                    for (int j = 0; j < count; j++) {
                      if (orders[j].order?.state == 'cancelled') {
                        cancelledOrders++;
                        debugPrint("======================$cancelledOrders");
                      }
                    }
                    return Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xffF9ECF0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10) //
                                            ),
                                      ),
                                      height: 90,
                                      width: 170,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22, top: 12),
                                            child: Text(
                                              "$cancelledOrders",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  Assets.image.cancelled.path,
                                                  width: 24,
                                                  height: 24,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                const Text(
                                                  'Cancelled',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 33,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xffF9ECF0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10) //
                                            ),
                                      ),
                                      height: 90,
                                      width: 170,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22, top: 12),
                                            child: Text(
                                              "$completedOrders",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  Assets.image.completed.path,
                                                  width: 24,
                                                  height: 24,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                const Text(
                                                  'Completed',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                              child: Text(
                                'Recent orders',
                                style: TextStyle(
                                  fontSize:   15,
                                ),  
                              ),
                            ),
                          ),
                          SliverList.builder(
                            itemBuilder: (context, index) => Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyOrderDetailsView(
                                        orders:
                                            state.myOrdersEntity.orders![index],
                                      ),
                                    ),
                                  );
                                },
                                child: MyOrderCard(
                                  myOrders: orders[index],
                                ),
                              ),
                            ),
                            itemCount: state.myOrdersEntity.orders!.length,
                          )
                        ],
                      ),
                    );
                  } else if (state is MyOrdersError) {
                    return const Center(child: Text('Error'));
                  }
                  return const SizedBox();
                }),
              ],
            ),
          ),
      
      ),
    );
  }
}
