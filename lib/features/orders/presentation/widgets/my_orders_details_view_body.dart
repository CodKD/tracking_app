import 'package:flutter/material.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/custom_card_address.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/custom_card_details.dart';
import 'package:tracking_app/features/orders/presentation/widgets/custom_card_order_details_for_my_orders_page.dart';
import '../../data/models/my_orders_response.dart';

class MyOrderDetailsViewBody extends StatelessWidget {
  const MyOrderDetailsViewBody({
    required this.orders,
    super.key,
  });

  // final String status;
  final Orders orders;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assets.image.completed.path,
                    ),
                    const SizedBox(width: 6),
                    Text(orders.order?.state ?? '',
                        style: const TextStyle(
                            color: Color(0xff0CB359),
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Text(
                      orders.order?.orderNumber ?? '',
                      style:
                          const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: CustomCardAddress(
            onTap: () {
              // go to pickup location view
            },
            noIcon: true,
            title: context.l10n.pickup_address,
            title2: orders.store?.name ?? '',
            phone: orders.store?.phoneNumber ?? '',
            name: orders.store?.name ?? '',
            location: orders.store?.address ?? '',
            urlImage: orders.store?.image ?? '',
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 24,
          ),
        ),
        SliverToBoxAdapter(
          child: CustomCardDetails(
          noIcon: true,
            title: context.l10n.pickup_address,
            title2: orders.order?.user?.firstName ?? '',
            phone: orders.order?.user?.phone ?? '',
            name: orders.order?.user?.firstName ?? '',
            urlImage: "https://flower.elevateegy.com/uploads/${orders.order?.user?.photo}",
           subTitle: orders.order?.user?.phone ?? '',
              
            ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 24,
          ),
        ),
        // SliverToBoxAdapter(
        //   child: CustomCardAddressForMyOrdersView(
        //     onTap: () {},
        //     noIcon: true,
        //     title: 'Pickup address',
        //     title2: orders.store?.name ?? '',
        //     phone: orders.store?.phoneNumber ?? '',
        //     name: orders.store?.name ?? '',
        //     location: orders.store?.address ?? '',
        //     urlImage: orders.store?.image ?? '',
        //   ),
        // ),
        // const SliverToBoxAdapter(
        //   child: SizedBox(
        //     height: 24,
        //   ),
        // ),
        // SliverToBoxAdapter(
        //   child: CustomCardAddressForMyOrdersView(
        //     onTap: () {},
        //     noIcon: false,
        //     title: 'User address',
        //     title2:
        //         '${orders.order?.user?.firstName} ${orders.order?.user?.lastName}',
        //     phone: orders.order?.user?.phone ?? '',
        //     name:
        //         '${orders.order?.user?.firstName} ${orders.order?.user?.lastName}',
        //     location: orders.order?.user?.phone ?? '',
        //     urlImage: orders.order?.user?.photo ?? '',
        //   ),
        // ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 24,
          ),
        ),
        const SliverToBoxAdapter(
          child: Text('Order details',
              style: TextStyle(
                fontSize: 16,
                
              )),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        SliverList.separated(
          itemCount: orders.order?.orderItems?.length,
          itemBuilder: (context, index) =>
              CustomCardOrderDetailsForMyOrdersPage(
            productInfo: orders.order?.orderItems![index],
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 8,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 24,
          ),
        ),
        SliverToBoxAdapter(
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Egp ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    orders.order!.totalPrice.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 24,
          ),
        ),
        SliverToBoxAdapter(
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text(
                    'Payment method',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    orders.order!.paymentType ?? '',
                    style:const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ) ,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
      ],
    );
  }
}
