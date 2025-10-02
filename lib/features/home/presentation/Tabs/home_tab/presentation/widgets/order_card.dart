import 'dart:developer';

import 'package:tracking_app/core/api_layer/firebase/firestore_manager.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';
import 'package:tracking_app/core/resources/app_constants.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/utils/caching/caching_helper.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/models/pending_orders_response.dart';

import 'store_info.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  final Orders orderPending;
  final VoidCallback onReject;

  const OrderCard({
    required this.orderPending,
    required this.onReject,
    super.key,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Flower order",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '24 Km - 30 mins to deliver',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            
            const SizedBox(height: 16),
            StoreInfo(
              title: 'store address',
              name:
                  widget.orderPending.store?.name
                      .toString() ??
                  "",
              address:
                  widget.orderPending.store?.address
                      .toString() ??
                  "",
              img:
                  widget.orderPending.store?.image ?? " ",
            ),
            const SizedBox(height: 16),
            StoreInfo(
              title: 'user address',
              name:
                  "${widget.orderPending.user?.firstName} ${widget.orderPending.user?.lastName}",
              address:
                  widget.orderPending.user?.phone ?? "",
              img:
                  "https://flower.elevateegy.com/uploads/${widget.orderPending.user?.photo}",
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("EGP", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.green,
                      ),),
                    const SizedBox(width: 3),
                    Text(
                      widget.orderPending.totalPrice.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(22),
                      ),
                      side: const BorderSide(
                        color: Colors.pink,
                      ),
                    ),

                    onPressed: widget.onReject,

                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    onPressed: isButtonDisabled
                        ? null
                        : () async {
                            setState(() {
                              isButtonDisabled = true;
                            });
                            // customLoadingDialog(context);
                            try {
                              await CacheService.setData(
                                key: CacheConstants
                                    .orderPendingId,
                                value: widget
                                    .orderPending
                                    .id,
                              );
                              await FirebaseUtils.addOrderToFirebase(
                                orders:
                                    widget.orderPending,
                              );
                              log(
                                "add order to firebase success",
                              );
                              await FirebaseUtils.saveDriverInOrderData(
                                CacheService.getData(
                                  key: CacheConstants
                                      .orderPendingId,
                                ),
                                Driver(
                                  long: '37',
                                  lat: '24',
                                  vehicleType: driverData
                                      ?.vehicleType,
                                  id: driverData?.id,
                                  phone:
                                      driverData?.phone,
                                  photo:
                                      driverData?.photo,
                                  firstName: driverData
                                      ?.firstName,
                                  lastName: driverData
                                      ?.lastName,
                                  email:
                                      driverData?.email,
                                ),
                              );
                              await FirebaseUtils.updateOrderState(
                                CacheService.getData(
                                  key: CacheConstants
                                      .orderPendingId,
                                ),
                                OrderStateModel(
                                  state: 'Accepted',
                                  updatedAt: DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                ),
                              );

                              context.pushReplacementNamed(
                                AppRoutes
                                    .orderDetailsScreen,
                              );
                            } catch (e) {
                              setState(() {
                                isButtonDisabled = false;
                              });
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Failed to accept order: $e',
                                  ),
                                ),
                              );
                              log(
                                'Failed to accept order: $e',
                              );
                            }
                          },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(22),
                      ),
                    

                      backgroundColor: isButtonDisabled
                          ? Colors.grey
                          : Colors.pink,
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
