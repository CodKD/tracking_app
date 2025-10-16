import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';
import 'package:tracking_app/core/utils/launch_url.dart';
import 'package:tracking_app/features/order_details/data/models/info_model.dart';

class InfoCardAddress extends StatelessWidget {
  const InfoCardAddress({
    super.key,
    required this.infoModel,
    this.onTap,
    required this.isUser,
  });

  final InfoModel infoModel;
  final void Function()? onTap;
  final isUser ;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[50],
      elevation: 4,
      margin: const EdgeInsets.all(0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        minTileHeight: 8,
        minVerticalPadding: 10,
        onTap: onTap,
        title: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          infoModel.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                CustomLaunchUrl.launchUrlCall(
                  numPhone: infoModel.phone,
                );
              },
              child: SvgPicture.asset(
                Assets.svg.call,
                width: 20,
                height: 20,
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                CustomLaunchUrl.launchUrlWhatsapp(
                  numPhone: infoModel.phone,
                  name: infoModel.title ,
                );
              },
              child: SvgPicture.asset(
                Assets.svg.whatsapp,
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
        leading: Container(
          width: 50,
          height: 50,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: infoModel.urlImage != null
              ? CachedNetworkImage(
                imageUrl: isUser
                    ? 'https://flower.elevateegy.com/uploads/${infoModel.urlImage!}'
                    : 'https://www.elevateegy.com/elevate.png',
                fit: BoxFit.fill,
              )
              : SvgPicture.asset(
                  infoModel.svgIconPath!,
                  fit: BoxFit.fill,
                ),
        ),
        subtitle: Row(
          children: [
             SvgPicture.asset(
                    Assets.svg.location,
                    width: 20,
                    height: 20,
                  )
                ,
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                infoModel.location,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}