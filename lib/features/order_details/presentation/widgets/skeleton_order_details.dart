
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/store_info.dart';

import 'custom_card_address.dart';

class OrderDetailsSkeleton extends StatefulWidget {
  const OrderDetailsSkeleton({super.key});

  @override
  State<OrderDetailsSkeleton> createState() => _OrderDetailsSkeletonState();
}

class _OrderDetailsSkeletonState extends State<OrderDetailsSkeleton> {



  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child:  ListView(
        children: [
          const SizedBox(height: 24,),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.pink.withOpacity(.1),
                borderRadius: BorderRadius.circular(12)),
            child: const Column(
              children: [
                Row(
                  children: [
                    Text('Status : ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text('status',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.pink)),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
               
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text('Wed, 03 Sep 2024, 11:00 AM  ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const CustomCardAddress(
            noIcon: true,
            title: 'Pickup address',
            title2: 'orderDetails.store?.name ?? ''',
            phone: 'orderDetails.store?',
            name: 'orderDetails..name ?? ''',
            location: 'orderDetails.store?.address ?? ''',
            urlImage:"https://flower.elevateegy.com/uploads/default-profile.png" ,
          ),
          const SizedBox(
            height: 16,
          ),
           const StoreInfo(
              title: "Pickup address",
              name:
                  "Elevate test",
              address:
                   "Test address",
              img:
                  "https://flower.elevateegy.com/uploads/default-profile.png",
            ),
          // const CustomCardAddress(
          //   noIcon: true,
          //   title: 'Pickup address',
          //   title2: 'orderDetails.store?.name ?? ''',
          //   phone: 'orderDetails.store?',
          //   name: 'orderDetails..name ?? ''',
          //   location: 'orderDetails.store?.address ?? ''',
          //   urlImage:"https://flower.elevateegy.com/uploads/default-profile.png" ,
          // ),
          const SizedBox(
            height: 16,
          ),
          const Text('title',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(
            height: 16,
          ),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.all(0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              minTileHeight: 8,
              minVerticalPadding: 10,
              // horizontalTitleGap: 8,
              title: const Text(
                'title2',
                style: TextStyle(
                    color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              trailing: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 8,
                  ),

                ],
              ),
              leading: Container(
                width: 50,
                clipBehavior: Clip.antiAlias,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Image.network(
                 "https://flower.elevateegy.com/uploads/default-profile.png",
                  fit: BoxFit.fill,
                ),
              ),
              subtitle: const Row(
                children: [

                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: Text(
                        'location',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}

List<String> buttonTitle = [
  'Arrived at Pickup point',
  'Arrived at Pickup point',
  'Start deliver',
  'Arrived to the user',
  'Delivered to the user'
];
