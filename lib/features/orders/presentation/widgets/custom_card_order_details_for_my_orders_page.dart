import 'package:flutter/material.dart';
import '../../data/models/my_orders_response.dart';

class CustomCardOrderDetailsForMyOrdersPage extends StatelessWidget {
  const CustomCardOrderDetailsForMyOrdersPage({super.key, this.productInfo});

  final OrderItems? productInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(0),
      child: ListTile(
        // ignore: deprecated_member_use
        splashColor: Colors.pink.withOpacity(.5),
        onTap: () {},
        contentPadding: const EdgeInsets.all(10),
        minTileHeight: 8,
        minVerticalPadding: 10,
        // horizontalTitleGap: 8,
        title: const Text(
          'Red roses,15 Pink Rose Bouquet',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Text(
          'X1',
          style:
              TextStyle(
                color: Colors.pink,
                fontSize: 14,
                fontWeight: FontWeight.w600
              ),
        ),
        leading: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
          child: Image.asset(
            "assets/images/image 2.png",
            height: 45,
            fit: BoxFit.fill,
          ),
        ),
        subtitle: Text(
          'EGP ${productInfo?.product?.price} ',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
