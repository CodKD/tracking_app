import 'package:flutter/material.dart';

class StoreInfo extends StatelessWidget {
  final String title;
  final String name;
  final String address;
  final String img;


  const StoreInfo({
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
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 3.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.pink,
                  child:  ClipOval( // Ensures that the image is clipped to a circle
    child: Image.network(
    img,
    fit: BoxFit.cover, // This will ensure the image covers the circle
    width: 40, // Width and height can be adjusted; should be 2 * radius
    height: 40,
    ),
    ),
                //Icon(iconImg,color: Colors.white,),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis, // Truncates text if too long
                      maxLines: 2, // Restrict to 2 lines
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