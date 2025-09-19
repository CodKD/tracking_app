import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/di/modules/shared_preferences_module.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/l10n/app_localizations.dart';
import 'package:tracking_app/core/resources/app_constants.dart';
import 'core/route/app_routes.dart';
import 'core/route/routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/language_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper().instantiatePreferences();
  final token = SharedPrefHelper().getValue(AppConstants.tokenKey);
  await configureDependencies();
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
      builder: (context, child) => BlocProvider(
        create: (context) => LocaleCubit(),
        child: BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Tracking app",
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale,
              theme: AppTheme.lightTheme,
              onGenerateRoute: Routes.generateRoute,
              initialRoute: AppRoutes.homeScreen,
            );
          },
        ),
      ),
    );
  }
}
