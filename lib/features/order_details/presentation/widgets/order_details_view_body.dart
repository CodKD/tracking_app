import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/models/pending_orders_response.dart';
import 'package:tracking_app/features/order_details/data/models/info_model.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/custom_card_details.dart';
import 'custom_card_address.dart';
import 'custom_card_order_details.dart';

class OrderDetailsViewBody extends StatelessWidget {
  const OrderDetailsViewBody({
    super.key,
    required this.status,
    required this.orderDetails,
  });

  final String status;
  final Orders orderDetails;

  @override
  Widget build(BuildContext context) {
    final List<InfoModel> storeInfoModel = [
      InfoModel(
        title:
            orderDetails.store?.name ?? 'Flowery Store',
        phone: orderDetails.store?.phoneNumber ?? "",
        location: orderDetails.store?.address ?? '',
        svgIconPath: Assets.svg.floweryLogo,
        urlImage: orderDetails.store?.image,
        latLng: orderDetails.store?.latLong
      ),
      InfoModel(
        title: '${orderDetails.user?.firstName}  ${orderDetails.user?.lastName ?? ""}',
        phone: orderDetails.user?.phone ?? "",
        location: "20th st, Sheikh Zayed, Giza",
        svgIconPath: Assets.svg.userPhoto,
        urlImage: orderDetails.user?.photo,
        latLng: null,      ),
    ];
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Colors.pink.withOpacity(.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${context.l10n.status} : ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      status,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${context.l10n.order_id} : ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      orderDetails.orderNumber ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      convertDateTime(
                        orderDetails.createdAt ?? '',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        SliverToBoxAdapter(
          child: CustomCardAddress(
            onTap: () {
              // go to pickup location view
              Navigator.pushNamed(
                context,
                AppRoutes.pickUpLocationView,
                arguments: {
                  "infoModels": storeInfoModel,
                  "selectedIndex": 0, // Store card first
                },
              );
            },
            noIcon: true,
            title: context.l10n.pickup_address,
            title2: orderDetails.store?.name ?? '',
            phone: orderDetails.store?.phoneNumber ?? '',
            name: orderDetails.store?.name ?? '',
            location: orderDetails.store?.address ?? '',
            urlImage: orderDetails.store?.image ?? '',
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
        SliverToBoxAdapter(
          child: CustomCardDetails(
            onTap: () {
              // go to user location view
              Navigator.pushNamed(
                context,
                AppRoutes.pickUpLocationView,
                arguments: {
                  "infoModels": storeInfoModel,
                  "selectedIndex": 1, // User card first
                },
              );
            },
          noIcon: true,
            title: context.l10n.pickup_address,
            title2: orderDetails.user?.firstName ?? '',
            phone: orderDetails.user?.phone ?? '',
            name: orderDetails.user?.firstName ?? '',
            urlImage: "https://flower.elevateegy.com/uploads/${orderDetails.user?.photo}",
           subTitle: orderDetails.user?.phone ?? '',
              
            ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
        SliverToBoxAdapter(
          child: Text(
            context.l10n.order_details,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        SliverList.separated(
          itemCount: orderDetails.orderItems?.length,
          itemBuilder: (context, index) =>
              CustomCardOrderDetails(
                productInfo:
                    orderDetails.orderItems?[index],
              ),
          separatorBuilder: (context, index) =>
              const SizedBox(height: 8),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
        SliverToBoxAdapter(
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    context.l10n.total,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'EGP ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    orderDetails.totalPrice.toString(),
                    style: const TextStyle(
                      color: Colors.pink,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
        SliverToBoxAdapter(
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    context.l10n.payment_method,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    orderDetails.paymentType ?? '',
                    style: const TextStyle(
                      color: Colors.pink,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
      ],
    );
  }
}

String convertDateTime(String inputDate) {
  DateTime dateTime = DateTime.parse(inputDate).toLocal();
  String formatedDate = DateFormat(
    "EEE, dd MMM yyyy, hh:mm a",
  ).format(dateTime);
  return formatedDate;
}
