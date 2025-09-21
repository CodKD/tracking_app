import 'package:flutter/material.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        context.pushNamed(AppRoutes.forgetPasswordScreen);
      },
      child: Text('click here'),
    );
  }
}
