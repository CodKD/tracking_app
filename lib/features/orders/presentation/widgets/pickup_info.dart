import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class PickupInfo extends StatelessWidget {
  final String title;
  final String name;
  final String address;
  final String img;

  const PickupInfo({
    super.key,
    required this.title,
    required this.name,
    required this.address,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          title,
          style: const TextStyle(fontWeight: FontWeight.w500,
              color: Colors.black,fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
           
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 45,
                  height: 45,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                  BoxDecoration(
                      borderRadius: BorderRadius.circular(50)),
                  child:CachedNetworkImage( height: 35,width: 35, imageUrl: img,)
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                       maxLines: 1,
          overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                       maxLines: 1,
         
                      style: const TextStyle(
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                     
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
