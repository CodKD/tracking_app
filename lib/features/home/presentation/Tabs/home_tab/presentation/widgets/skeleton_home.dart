
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/store_info.dart';




class SkeletonHome extends StatefulWidget {
  const SkeletonHome({super.key});

  @override
  State<SkeletonHome> createState() => _SkeletonHomeState();
}

class _SkeletonHomeState extends State<SkeletonHome> {



  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child:  ListView(
        children: [
          Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 4,
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
                  const Row(
                    children: [
                      Icon(Icons.timer, color: Color(0xffC8D444)),
                      SizedBox(width: 8),
                      Text('Pending',
                          style: TextStyle(color: Color(0xffC8D444), fontSize: 16)),
                      Spacer(),
                      Text(
                        'user address',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const StoreInfo(
                    title: 'store address',
                    name: "SDSSSSSSSSSSSSSSS",
                    address:"SDSSSSSSSSSSSSSSS",
                    img: "https://flower.elevateegy.com/uploads/default-profile.png" ,
                  ),
                  const SizedBox(height: 16),
                  const StoreInfo(
                    title: 'user address',
                    name:
                    'user address',
                    address: 'user address',
                    img:
                    "https://flower.elevateegy.com/uploads/default-profile.png" ,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'SSSSSSSSSSSSSSSSSS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 4,
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
                  const Row(
                    children: [
                      Icon(Icons.timer, color: Color(0xffC8D444)),
                      SizedBox(width: 8),
                      Text('Pending',
                          style: TextStyle(color: Color(0xffC8D444), fontSize: 16)),
                      Spacer(),
                      Text(
                        'user address',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const StoreInfo(
                    title: 'store address',
                    name: "SDSSSSSSSSSSSSSSS",
                    address:"SDSSSSSSSSSSSSSSS",
                    img: "https://flower.elevateegy.com/uploads/default-profile.png" ,
                  ),
                  const SizedBox(height: 16),
                  const StoreInfo(
                    title: 'user address',
                    name:
                    'user address',
                    address: 'user address',
                    img:
                    "https://flower.elevateegy.com/uploads/default-profile.png" ,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'SSSSSSSSSSSSSSSSSS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


