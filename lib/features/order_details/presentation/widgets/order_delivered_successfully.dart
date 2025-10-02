
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/utils/caching/caching_helper.dart';


class OrderDeliveredSuccessfully extends StatelessWidget {
  const OrderDeliveredSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.svg.orderSuccessfullyIcon),
              const SizedBox(
                height: 32,
              ),
               Text(
                context.l10n.thank_you,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
               Text(
                context.l10n.order_delivered,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
               Text(
                context.l10n.successfully,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 48,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                 minimumSize: const Size(double.infinity, 50),
              
                ),
                  onPressed: () {
                  CacheService.deleteItem(key: CacheConstants.orderPendingId);
                     CacheService.deleteItem(key: CacheConstants.currentStep);
                     debugPrint(
                         '88888888888888888888888888888888888888888888888888888888'
                             '///////////////////////////$orderPendingId'
                             '///////////////////99999999999999999999999999999999999'

                     );

                     context.pushReplacementNamed(AppRoutes.homeScreen);
                  }, child:  Text(context.l10n.done,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),)
            ],
          ),
        ),
      ),
    );
  }
}
