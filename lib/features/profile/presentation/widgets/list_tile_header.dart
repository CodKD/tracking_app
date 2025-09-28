import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/features/profile/presentation/widgets/logout_user.dart';
import '../../../../core/utils/language_cubit.dart';

class ListTileHeader extends StatelessWidget {
  const ListTileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = Localizations.localeOf(context).languageCode;

    return Column(
      children: [
        const Divider(thickness: 0.3, color: AppColors.grey),
        ListTile(
          onTap: () {
            if (currentLang == "en") {
              context.read<LocaleCubit>().changeLang("ar");
            } else {
              context.read<LocaleCubit>().changeLang("en");
            }
          },
          leading: Icon(Icons.translate, size: 24.w),
          trailing: Text(
            currentLang == "en" ? "English" : "العربية",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColors.pink),
          ),
          title: Text(
            currentLang == "en" ? "Language" : "اللغة",

            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        // logout
        ListTile(
          onTap: () {
            logoutUser(context);
          },
          leading: Icon(Icons.logout_outlined, size: 24.w),
          trailing: Icon(
            Icons.logout_outlined,
            size: 23.w,
            color: AppColors.grey,
          ),
          title: Text(
            context.l10n.logout,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
