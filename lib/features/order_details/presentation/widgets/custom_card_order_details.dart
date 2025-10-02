
import 'package:flutter/material.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/models/pending_orders_response.dart';




class CustomCardOrderDetails extends StatelessWidget {
  const CustomCardOrderDetails({super.key, this.productInfo});

  final OrderItems? productInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: ListTile(
        splashColor: Colors.pink.withOpacity(.5),
        onTap: () {
        },
        contentPadding: const EdgeInsets.all(10),
        minTileHeight: 8,
        minVerticalPadding: 10,
        title: Text(
          productInfo?.product?.title??'',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, ),
        ),
        trailing: Text(
          'X${productInfo?.quantity}',
          style: const TextStyle(color: Colors.pink, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        leading: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50)
          ),
          child: Image.network(
              "https://flower.elevateegy.com/uploads/${productInfo?.product?.imgCover}",fit: BoxFit.fill,),
        ),
        subtitle: Text(
          'EGP ${productInfo?.product?.priceAfterDiscount} ',
          style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
