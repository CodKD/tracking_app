
import 'package:flutter/material.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';
import 'package:tracking_app/features/orders/presentation/widgets/pickup_info.dart';

import '../../data/models/my_orders_response.dart';

class MyOrderCard extends StatefulWidget {
  final Orders myOrders;

  const MyOrderCard({required this.myOrders, super.key});

  @override
  State<MyOrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<MyOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Flower order",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Image.asset(
                  Assets.image.completed.path,
                ),
                const SizedBox(width: 6),
                Text(widget.myOrders.order?.state ?? '',
                    style: const TextStyle(
                        color: Color(0xff0CB359),
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                const Spacer(),
                Text(
                  widget.myOrders.order?.orderNumber ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            PickupInfo(
              title: 'Pickup address',
              name: widget.myOrders.store?.name ?? '',
              address: widget.myOrders.store?.address ?? '',
              img: widget.myOrders.store?.image ?? '',
            ),
            const SizedBox(height: 16),
            PickupInfo(
              title: 'user address',
              name:
              '${widget.myOrders.order?.user?.firstName ?? ''} ${widget.myOrders.order?.user?.lastName ?? ''}',
              address: widget.myOrders.order?.user?.phone ?? '',
              img:
              "https://flower.elevateegy.com/uploads/${widget.myOrders.order?.user?.photo ?? ''}",
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}