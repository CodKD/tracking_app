import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/core/utils/components/app_text_form_feild.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:tracking_app/features/profile/presentation/view_model/cubit.dart';
import '../../../../core/di/di.dart';

class EditeVehicalInfo extends StatelessWidget {
  const EditeVehicalInfo({
    super.key,
    required this.driver,
  });

  final ProfileDriverEntity driver;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<ProfileCubit>();
        cubit.initializeVehicle(driver);
        cubit.loadVehicles();
        return cubit;
      },
      child: const _EditVehicleView(),
    );
  }
}

class _EditVehicleView extends StatelessWidget {
  const _EditVehicleView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.edit_vehical_info),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) =>
              current is GetVehiclesLoading ||
              current is GetVehiclesError ||
              current is GetVehiclesSuccess ||
              current is ProfileInitial ||
              current is GetLoggedDriverDataSuccess,
          builder: (context, state) {
            switch (state) {
              case GetVehiclesLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case GetVehiclesError():
                return Center(child: Text(state.message));
              case GetLoggedDriverDataError():
                return Center(child: Text(state.message));
              case GetLoggedDriverDataLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case GetVehiclesSuccess():
                final vehicles = state.vehicles;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        items: vehicles
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        decoration: InputDecoration(
                          labelText:
                              context.l10n.vehicle_type,
                          labelStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14.sp,
                          ),
                          border:
                              const OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          cubit.vehicleTypeController =
                              TextEditingController(
                                text: value,
                              );
                        },
                      ),
                      SizedBox(height: 23.h),
                      AppTextFormField(
                        controller:
                            cubit.vehicleNumberController,
                        hintText: context
                            .l10n
                            .enter_vehicle_number,
                        labelText:
                            context.l10n.vehicle_number,
                        validator: (v) =>
                            (v == null || v.isEmpty)
                            ? context.l10n.vehicleNumber
                            : null,
                        isPassword: false,
                      ),
                      SizedBox(height: 23.h),
                      BlocBuilder<
                        ProfileCubit,
                        ProfileState
                      >(
                        builder: (context, state) {
                          return FormField<File>(
                            validator: (value) {
                              if (cubit.vehicleLicense ==
                                  null) {
                                return context
                                    .l10n
                                    .uploadVehicleLicenseError;
                              }
                              return null;
                            },
                            builder: (field) {
                              return InkWell(
                                onTap: () {
                                  cubit
                                      .pickVehicleLicenseImage();
                                },
                                child: IgnorePointer(
                                  child: TextFormField(
                                    keyboardType:
                                        TextInputType
                                            .number,
                                    decoration: InputDecoration(
                                      labelText: context
                                          .l10n
                                          .vehicleLicense,
                                      labelStyle:
                                          TextStyle(
                                            color:
                                                AppColors
                                                    .grey,
                                            fontSize:
                                                14.sp,
                                          ),
                                      hintText: context
                                          .l10n
                                          .choose_vehicle_license_img,
                                      hintStyle:
                                          TextStyle(
                                            color:
                                                AppColors
                                                    .grey,
                                            fontSize:
                                                14.sp,
                                          ),
                                      border:
                                          const OutlineInputBorder(),
                                      errorText:
                                          field.hasError
                                          ? field
                                                .errorText
                                          : null,
                                      suffixIcon:
                                          cubit.vehicleLicense ==
                                              null
                                          ? const Icon(
                                              Icons
                                                  .file_upload,
                                            )
                                          : IconButton(
                                              icon: const Icon(
                                                Icons
                                                    .close,
                                                color: Colors
                                                    .red,
                                              ),
                                              onPressed: () {
                                                cubit
                                                    .clearVehicleLicense();
                                              },
                                            ),
                                    ),
                                    readOnly: true,
                                    style: TextStyle(
                                      color:
                                          AppColors.grey,
                                      fontSize: 12.sp,
                                      backgroundColor:
                                          cubit.vehicleLicense !=
                                              null
                                          ? AppColors
                                                .pink
                                                .shade200
                                          : Colors
                                                .transparent,
                                    ),
                                    controller: TextEditingController(
                                      text:
                                          cubit.vehicleLicense !=
                                              null
                                          ? cubit.getFileName(
                                              cubit
                                                  .vehicleLicense!
                                                  .path,
                                            )
                                          : '',
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),

                      // Vehicle License
                      const SizedBox(height: 32),

                      // Update Button
                      CustomButton(
                        size: Size(double.infinity, 48.h),
                        borderRadius: 25.r,
                        child: Text(context.l10n.update),
                        onPressed: () {
                          context
                              .read<ProfileCubit>()
                              .updateVehicleInfo();
                        },
                      ),
                    ],
                  ),
                );
              case GetLoggedDriverDataSuccess():
                // TODO: Handle this case.
                throw UnimplementedError();
              case PhotoChangedLoadingState():
                // TODO: Handle this case.
                throw UnimplementedError();
              case PhotoChangedSuccess():
                // TODO: Handle this case.
                throw UnimplementedError();
              case PhotoChangedError():
                // TODO: Handle this case.
                throw UnimplementedError();
              case UpdateUserProfileLoading():
                // TODO: Handle this case.
                throw UnimplementedError();
              case UpdateUserProfileSuccess():
                // TODO: Handle this case.
                throw UnimplementedError();
              case UpdateUserProfileError():
                // TODO: Handle this case.
                throw UnimplementedError();
              case DriverApplyLicenseImagePicked():
                // TODO: Handle this case.
                throw UnimplementedError();
              case DriverApplyImageError():
                // TODO: Handle this case.
                throw UnimplementedError();
              case DriverApplyLicenseImageCleared():
                // TODO: Handle this case.
                throw UnimplementedError();
              case ProfileInitial():
                // TODO: Handle this case.
                throw UnimplementedError();
            }
          },
        ),
      ),
    );
  }
}
