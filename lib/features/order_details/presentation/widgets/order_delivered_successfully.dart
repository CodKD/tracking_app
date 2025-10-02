
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/utils/caching/caching_helper.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';


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
              const Text(
                'Thank you!!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'The order delivered ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const Text(
                'successfully ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 48,
              ),
              CustomButton(
                  onPressed: () {
                  CacheService.deleteItem(key: CacheConstants.orderPendingId);
                     CacheService.deleteItem(key: CacheConstants.currentStep);
                     print(
                         '88888888888888888888888888888888888888888888888888888888'
                             '///////////////////////////$orderPendingId'
                             '///////////////////99999999999999999999999999999999999'

                     );

                     context.pushReplacementNamed(AppRoutes.homeScreen);
                  }, child: const Text('Done'),)
            ],
          ),
        ),
      ),
    );
  }
}
