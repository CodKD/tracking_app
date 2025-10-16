import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';


class CustomCardAddressForMyOrdersView extends StatelessWidget {
  const CustomCardAddressForMyOrdersView(
      {super.key,
        required this.title,
        required this.phone,
        this.name,
        required this.location,
        required this.title2,
        required this.urlImage,
        required this.noIcon,
        this.onTap});

  final String title;
  final String title2;
  final String phone;
  final String? name;
  final String location;
  final String urlImage;
  final bool noIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
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
            onTap: onTap,
            // horizontalTitleGap: 8,
            title: Text(
              title2,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: Container(
                width: 50,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child:CachedNetworkImage( imageUrl: urlImage,)
            ),
            subtitle: Row(
              children: [
                noIcon
                    ? SvgPicture.asset(
                  Assets.svg.location,
                  width: 20,
                  height: 20,
                )
                    : const SizedBox(),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                    child: Text(
                      location,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
