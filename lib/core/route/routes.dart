import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/features/auth/apply/presentation/view/application_approved_screen.dart';
import 'package:tracking_app/features/auth/apply/presentation/view/apply_screen.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/pages/forget_password_view.dart';
import 'package:tracking_app/features/home/presentation/home_screen.dart';
import 'package:tracking_app/features/auth/login/presentation/login_view.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';
import 'package:tracking_app/features/pick_up_location/presentation/cubit/pick_up_location_cubit.dart';
import 'package:tracking_app/features/profile/presentation/view/edit_profile.dart';
import 'package:tracking_app/features/profile/presentation/view/notification_list.dart';
import 'package:tracking_app/features/profile/presentation/view/reset_password.dart';
import 'package:tracking_app/features/order_details/presentation/pages/order_details_view.dart';
import 'package:tracking_app/features/pick_up_location/presentation/view/pick_up_location_view.dart';

import '../../features/onboarding/onboarding_view.dart';
import '../../features/profile/domain/entities/get_logged_driver_entity.dart';
import '../../features/profile/presentation/view/edite_vehical_info.dart';

abstract class Routes {
  static Route generateRoute(RouteSettings settings) {
    final url = Uri.parse(settings.name ?? "/");
    switch (url.path) {
      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case AppRoutes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) =>
              const ForgetPasswordView(),
        );
      case AppRoutes.loginView:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case AppRoutes.orderDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => const OrderDetailsView(),
        );
      case AppRoutes.pickUpLocationView:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> args =
                settings.arguments
                    as Map<String, dynamic>? ??
                {};

            return BlocProvider(
              create: (context) =>
                  getIt<PickUpLocationCubit>()
                    ..initializeLocation(args['isUserLocation']),
              child: PickUpLocationViewBody(args: args),
            );
          },
        );
      case AppRoutes.onBoardingView:
        return MaterialPageRoute(
          builder: (context) => const OnboardingView(),
        );
      case AppRoutes.notificationList:
        return MaterialPageRoute(
          builder: (context) => const NotificationList(),
        );
      case AppRoutes.editProfile:
        return MaterialPageRoute(
          builder: (context) {
            final args =
                settings.arguments as ProfileDriverEntity;
            return EditProfile(driver: args);
          },
          builder: (context) => const EditProfile(),
        );
      case AppRoutes.applicationApprovedScreen:
        return MaterialPageRoute(
          builder: (context) =>
              const ApplicationApprovedScreen(),
        );
      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (context) => const ResetPassword(),
        );
      case AppRoutes.editeVehicalInfo:
        return MaterialPageRoute(
          builder: (context) {
            final args =
                settings.arguments as ProfileDriverEntity;
            return EditeVehicalInfo(driver: args);
          },

          builder: (context) => const EditeVehicalInfo(),
        );
      case AppRoutes.applyScreen:
        return MaterialPageRoute(
          builder: (context) => const ApplyScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundScreen(),
        );
    }
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Assets.image.noRoutes.image(
                  width: context.width,
                  height: context.height,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 50,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        "404 Not Found ",
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                          color: AppColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5,
                  ),
                  child: Text(
                    "Oops! We couldn't find the page you're looking for.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: AppColors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                (context.height * 0.02).heightBox,
                SizedBox(
                  width: context.width * 0.6,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.onBoardingView,
                      );
                    },
                    child: const Text("Go to Home"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
