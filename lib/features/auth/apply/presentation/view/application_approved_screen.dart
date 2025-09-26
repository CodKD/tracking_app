import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';

class ApplicationApprovedScreen extends StatelessWidget {
  const ApplicationApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            100.heightBox,
            Center(
              child: SvgPicture.asset(
                Assets.svg.vector,
                width: context.width * 0.2,
                height: context.height * 0.2,
              ),
            ),
            50.heightBox,
            Text(
              context.l10n.apply_submitted_successfully,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            15.heightBox,
            Text(
              textAlign: TextAlign.center,
              context.l10n.apply_submitted_description,
            ),
            30.heightBox,
            CustomButton(
              size: Size(context.width * 0.9, 50),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.loginView);
              },
              borderRadius: 100,

              child: Text(context.l10n.login, style: AppStyles.medium16white),
            ),
            SvgPicture.asset(
              Assets.svg.bg,
              width: context.width,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
