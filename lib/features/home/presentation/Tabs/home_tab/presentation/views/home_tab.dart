import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/cubit/home_tab_cubit.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/available_for_delivery.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/order_card.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/refresh_home.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/skeleton_home.dart';

import '../../data/models/pending_orders_response.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeTab> {
  late HomeTabCubit viewModel;
  late String savedToken;
  late List<Orders> ordersViewed;
  bool isRefreshIndicator = true;
  bool isAvailable = true;

  @override
  void initState() {
    viewModel = getIt<HomeTabCubit>();

    super.initState();
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Colors.white,
      displacement: 0,
      color: Colors.pink,
      onRefresh: () {
        isRefreshIndicator = false;
        return viewModel.getHomeData();
      },
      child: BlocProvider(
        create: (context) => viewModel..getHomeData(),
        child: Column(
            children: [
            
              isAvailable
                  ? BlocConsumer<HomeTabCubit, HomeTabState>(
                      listener: (context, state) {
                      if (state is HomeTabSuccess) {
                        isRefreshIndicator = true;
                      }
                    }, builder: (context, state) {
                      if (state is HomeTabLoading) {
                        return const Expanded(child: SkeletonHome());
                      } else if (state is HomeTabSuccess) {
                        PendingDriverOrdersEntity pendingDriverOrdersEntity =
                            state.pendingDriverOrdersEntity;
                        List<Orders> orders =
                            pendingDriverOrdersEntity.orders ?? [];
        
                        return orders.isNotEmpty
                            ? Expanded(
                                child: Stack(
                                  clipBehavior: Clip.antiAlias,
                                  children: [
                                    ListView.builder(
                                      itemCount: orders.length,
                                      itemBuilder: (context, index) {
                                        return OrderCard(
                                          orderPending: orders[index],
                                          onReject: () {
                                            viewModel.rejectOrderFromScreen(
                                                orders[index]);
                                          },
                                        );
                                      },
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 25,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.pink
                                              // ignore: deprecated_member_use
                                              .withOpacity(.6),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          orders.length.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Expanded(
                                child: RefreshHome(
                                    viewModel: viewModel,
                                    savedToken: savedToken),
                              );
                      } else {
                        return  Center(child: Text(context.l10n.error));
                      }
                    })
                  : const Expanded(child: AvailableForDelivery()),
            ],
          ),
      ),
    );
  }
}
