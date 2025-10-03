import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/extensions/spacer_media_quiey.dart';
import 'package:tracking_app/core/input_formatter/app_regex.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/core/theme/app_theme.dart';
import 'package:tracking_app/core/utils/components/app_text_form_feild.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/vehicle.dart';
import 'package:tracking_app/features/profile/presentation/view_model/cubit.dart';
import 'package:tracking_app/features/profile/presentation/view_model/edit_vehicle_view_modle/edit_vehical_cubit.dart'
    hide ProfileCubit, ProfileState, GetLoggedDriverDataSuccess;
import '../../../../../../core/di/di.dart';
import '../../../../../../core/dialog/dialog.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/route/app_routes.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user =
        ModalRoute.of(context)?.settings.arguments as ProfileDriverEntity?;
    return BlocProvider(
      create: (context) =>
          getIt<EditVehicalCubit>()..initializeWithUser(user as VehicleEntity?),
      child: EditProfileView(gender: user?.gender ?? ""),
    );
  }
}

class EditProfileView extends StatelessWidget {
  EditProfileView({required this.gender, super.key});

  final String gender;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("editProfile"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<EditVehicalCubit, VehicalState>(
          listener: (context, state) {
            if (state is UpdateUserProfileLoading ||
                state is PhotoChangedLoadingState) {
              DialogUtils.showLoading(
                context: context,
                loadingMessage: context.l10n.loading,
              );
            } else if (state is GetLoggedDriverDataSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppTheme.lightTheme.primaryColor,
                  content: Text("profileUpdatedSuccessfully"),
                ),
              );
              Navigator.pushReplacementNamed(context, AppRoutes.loginView);
            } else if (state is PhotoChangedSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppTheme.lightTheme.primaryColor,
                  content: Text("photoUpdatedSuccessfully"),
                ),
              );
              Navigator.of(context).pop(true);
            } else if (state is UpdateUserProfileError) {
              Navigator.of(context).pop(false);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is PhotoChangedError) {
              Navigator.of(context).pop(false);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              final cubit = context.read<ProfileCubit>();
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),

                                child: cubit.selectedImageFile != null
                                    ? Image.file(
                                        cubit.selectedImageFile!,
                                        width: 100.w,
                                        height: 100.h,
                                        fit: BoxFit.fill,
                                      )
                                    : cubit.photo.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: cubit.photo,
                                        fit: BoxFit.fill,
                                        width: 100.w,
                                        height: 100.h,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                              child: Icon(Icons.error),
                                            ),
                                      )
                                    : Image.asset(
                                        Assets.image.noRoutes.path,
                                        width: 100.w,
                                        height: 100.h,
                                        fit: BoxFit.fill,
                                      ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            width: 30.w,
                            height: 30.h,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              child: GestureDetector(
                                // onTap: () {
                                //   context
                                //       .read<ProfileCubit>()
                                //       .changeUserPhoto();
                                // },
                                child: SvgPicture.asset(Assets.svg.bg),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.heightPercent(context)),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            hintText: context.l10n.first_name,
                            controller: context
                                .read<ProfileCubit>()
                                .firstNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return context.l10n.descriptionFirstName;
                              }
                              if (value.length < 2) {
                                return context
                                    .l10n
                                    .nameMustBeMoreThan3Characters;
                              }
                              return null;
                            },
                            isPassword: false,
                          ),
                        ),
                        SizedBox(width: 6.widthPercent(context)),
                        Expanded(
                          child: AppTextFormField(
                            hintText: context.l10n.last_name,
                            controller: context
                                .read<ProfileCubit>()
                                .lastNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return context.l10n.descriptionLastName;
                              }
                              if (value.length < 2) {
                                return context
                                    .l10n
                                    .nameMustBeMoreThan3Characters;
                              }
                              return null;
                            },
                            isPassword: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.heightPercent(context)),
                    AppTextFormField(
                      hintText: context.l10n.email,
                      controller: context.read<ProfileCubit>().emailController,
                      isPassword: false,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !AppRegex.isEmailValid(value)) {
                          return context.l10n.descriptionEmail;
                        }
                        if (!AppRegex.isEmailValid(value)) {
                          return context.l10n.descriptionEmail;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.heightPercent(context)),
                    AppTextFormField(
                      controller: context.read<ProfileCubit>().phoneController,
                      isPassword: false,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                      ),
                      hintText: context.l10n.enter_phone,
                      validator: (value) {
                        if (value == null || value.isEmpty
                        //!AppRegex.isPhoneNumberValid(value)
                        ) {
                          return context.l10n.descriptionPhoneNumber;
                        }
                        if (!AppRegex.isPhoneNumberValid(value)) {
                          return context.l10n.enterAValidEgyptianPhoneNumber;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.heightPercent(context)),
                    AppTextFormField(
                      controller: TextEditingController(text: "********"),
                      suffixIcon: TextButton(
                        onPressed: () {
                          context.pushNamed(AppRoutes.notificationList);
                        },
                        child: Text("change"),
                      ),
                      isPassword: false,
                      hintText: context.l10n.pleaseEnterYourPassword,
                    ),
                    SizedBox(height: 1.5.heightPercent(context)),
                    CustomButton(
                      size: Size(double.infinity, 48.h),
                      borderRadius: 25.r,
                      child: Text("update"),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<ProfileCubit>()
                              .getLoggedUserDataUseCase();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
