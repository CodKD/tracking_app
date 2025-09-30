

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/models/pending_orders_response.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/cubit/home_tab_cubit.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/order_card.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  late List<Orders> ordersViewed;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeTabCubit = getIt<HomeTabCubit>();
    return BlocProvider(
      create: (context) =>  homeTabCubit..getHomeData(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<HomeTabCubit, HomeTabState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is HomeTabLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is HomeTabSuccess) {
                    PendingDriverOrdersEntity pendingDriverOrdersEntity =
                        state.pendingDriverOrdersEntity;
                    var orders = pendingDriverOrdersEntity.orders;
          
                    return ListView.builder(
                      itemCount: orders?.length,
                      itemBuilder: (context, index) {
                        return OrderCard(
                          
                          orderPending: orders![index],
                          onReject: () {
                            homeTabCubit.rejectOrderFromScreen(orders[index]);
                          },
                        );
                      },
                    );
                  } else  if (state is HomeTabFail) {
                    return Center(child: Text(state.errorMessage));
                  } else {
                    return const Center(child: Text('Error'));
                  }
                });
        }
      ),
    
    );
  }
}
