
import 'package:flutter/material.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/models/pending_orders_response.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/stor_info.dart';

class OrderCard extends StatefulWidget {
  final Orders orderPending;
  final VoidCallback onReject;

  const OrderCard(
      {required this.orderPending, required this.onReject, super.key });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Flower order",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text('24 Km - 30 mins to deliver',
                style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timer, color: Color(0xffC8D444)),
                const SizedBox(width: 8),
                const Text('Pending',
                    style: TextStyle(color: Color(0xffC8D444), fontSize: 16)),
                const Spacer(),
                Text(
                  widget.orderPending.orderNumber ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            StoreInfo(
              title: 'store address',
              name: widget.orderPending.store?.name.toString() ?? "",
              address: widget.orderPending.store?.address.toString() ?? "",
              img: widget.orderPending.store?.image ?? " ",
            ),
            const SizedBox(height: 16),
            StoreInfo(
              title: 'user address',
              name: widget.orderPending.user?.firstName ?? "",
              address: widget.orderPending.user?.phone ?? "",
              img: "https://flower.elevateegy.com/uploads/${widget.orderPending
                  .user?.photo}",
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.orderPending.totalPrice.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: widget.onReject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: AppColors.pink),
                      foregroundColor: AppColors.pink,
                    ),
                    child: const Text('Reject'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // CacheService.setData(
                    //     key: CacheConstants.orderPendingId,
                    //     value: widget.orderPending.id);
                    // FirebaseUtils.addOrderToFirebase(
                    //     orders: widget.orderPending);
                    // Navigator
                    //     .pushReplacement(context, MaterialPageRoute(builder: (context)
                    // =>
                    //     OrderDetailsView()
                    // ))
                    // ;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
