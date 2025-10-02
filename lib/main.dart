import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/modules/shared_preferences_module.dart';
import 'package:tracking_app/core/l10n/app_localizations.dart';
import 'package:tracking_app/core/resources/app_constants.dart';
import 'package:tracking_app/core/utils/caching/caching_helper.dart';
import 'package:tracking_app/firebase_options.dart';
import 'core/route/app_routes.dart';
import 'core/route/routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/language_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await CacheService.cacheInitialization();
  final sharedPrefHelper = getIt<SharedPrefHelper>();
  final token = sharedPrefHelper.getValue(AppConstants.tokenKey);
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.token});

  final String? token;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 813),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>
          BlocProvider(
            create: (context) => getIt<LocaleCubit>(),
            child: BlocBuilder<LocaleCubit, Locale>(
              builder: (context, locale) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Tracking app",
                  localizationsDelegates: AppLocalizations
                      .localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: locale,
                  theme: AppTheme.lightTheme,
                  onGenerateRoute: Routes.generateRoute,
                  initialRoute: token != null
                      ? AppRoutes.loginView
                      : AppRoutes.onBoardingView,
                );
              },
            ),
          ),    );
  }
}
