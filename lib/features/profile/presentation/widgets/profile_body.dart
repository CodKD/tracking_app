import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/extensions/spacer_media_quiey.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/features/profile/presentation/view_model/cubit.dart';
import 'package:tracking_app/features/profile/presentation/widgets/list_tile_header.dart';
import '../../../../core/route/app_routes.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is GetLoggedDriverDataSuccess ||
          current is GetLoggedDriverDataError ||
          current is GetLoggedDriverDataLoading,
      builder: (context, state) {
        switch (state) {
          case GetLoggedDriverDataLoading():
            return const Center(child: CircularProgressIndicator());
          case GetLoggedDriverDataError():
            return Center(child: Text(state.message));
          case GetLoggedDriverDataSuccess():
            return Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.editProfile);
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.network(
                          state.driver.photo ?? "",
                          fit: BoxFit.cover,
                          width: 60.w,
                          height: 60.w,
                        ),
                      ),
                      title: Text(
                        "${state.driver.firstName ?? ''} ${state.driver.lastName ?? ''}",
                        style: AppStyles.font20BlackW500,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.driver.email ?? '',
                            style: AppStyles.regular16black,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            state.driver.phone ?? '',
                            style: AppStyles.regular16black,
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  20.heightBox,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.editProfile);
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        "Vehicle info",
                        style: AppStyles.font20BlackW500,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.driver.vehicleType!.hexToString(),
                            style: AppStyles.regular16black,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            state.driver.vehicleNumber ?? '',
                            style: AppStyles.regular16black,
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.5.heightPercent(context)),
                  const ListTileHeader(),
                  const Spacer(),
                  Text(
                    context.l10n.appVersion,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          case ProfileInitial():
            throw UnimplementedError();
          case UpdateUserProfileLoading():
            throw UnimplementedError();
          case UpdateUserProfileSuccess():
            throw UnimplementedError();
          case UpdateUserProfileError():
            throw UnimplementedError();
          case PhotoChangedLoadingState():
            throw UnimplementedError();
          case PhotoChangedSuccess():
            throw UnimplementedError();
          case PhotoChangedError():
            throw UnimplementedError();
        }
      },
    );
  }
}
