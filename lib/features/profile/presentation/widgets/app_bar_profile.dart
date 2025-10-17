import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/core/theme/app_styles.dart';

class AppBarProfile extends StatelessWidget {
  const AppBarProfile({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title, style: AppStyles.font20BlackW500),
          ],
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoutes.notificationList);
          },
          child: Stack(
            children: [
              Icon(
                Icons.notifications_none_outlined,
                size: 29.w,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 15.w,
                  height: 15.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.red,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '3',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
