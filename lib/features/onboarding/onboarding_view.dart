import 'package:flutter/material.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Assets.image.onboarding.image(
                width: context.width,
                height: context.height * 0.5,
              ),
              7.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.l10n.welcome_to_flowery_rider_app,
                      style: AppStyles.font20BlackW500,
                    ),
                    24.heightBox,
                    CustomButton(
                      onPressed: () {
                        context.pushReplacementNamed(AppRoutes.loginView);
                      },
                      borderRadius: 100,
                      child: Text(
                        context.l10n.login,
                        style: AppStyles.medium16white,
                      ),
                    ),
                    16.heightBox,
                    CustomButton(
                      onPressed: () {
                        //TODO: apply now action
                      },
                      borderRadius: 100,
                      backgroundColorButton: AppColors.white,
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.black,
                      ),
                      child: Text(
                        context.l10n.apply_now,
                        style: AppStyles.medium16black,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                context.l10n.version,
                textAlign: TextAlign.center,
                style: AppStyles.regular11grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
