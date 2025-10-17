import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/components/app_text_form_feild.dart';

class EditeVehicalInfo extends StatelessWidget {
  const EditeVehicalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.edit_vehical_info),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
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
                        value:
                            vehicles.contains(
                              cubit
                                  .vehicleTypeController
                                  .text,
                            )
                            ? cubit
                                  .vehicleTypeController
                                  .text
                            : null,

                        items: vehicles.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.motorcycle,
                                  color: AppColors.pink,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color:
                                        AppColors.black,
                                    fontWeight:
                                        FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText:
                              context.l10n.vehicle_type,
                          labelStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding:
                              EdgeInsets.symmetric(
                                vertical: 14.h,
                                horizontal: 16.w,
                              ),
                          enabledBorder:
                              OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                      16,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors
                                      .grey
                                      .shade300,
                                  width: 1,
                                ),
                              ),
                          focusedBorder:
                              OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                      16,
                                    ),
                                borderSide:
                                    const BorderSide(
                                      color:
                                          AppColors.pink,
                                      width: 1.5,
                                    ),
                              ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.redAccent,
                              width: 1,
                            ),
                          ),
                        ),
                        icon: const Icon(
                          Icons
                              .keyboard_arrow_down_rounded,
                          color: AppColors.pink,
                          size: 26,
                        ),
                        dropdownColor: Colors.white,
                        borderRadius:
                            BorderRadius.circular(16),
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
                                    readOnly: true,
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
                                    style: TextStyle(
                                      color:
                                          AppColors.grey,
                                      fontSize: 12.sp,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: context
                                          .l10n
                                          .vehicleLicense,
                                      hintText: context
                                          .l10n
                                          .choose_vehicle_license_img,
                                      labelStyle:
                                          TextStyle(
                                            color:
                                                AppColors
                                                    .grey,
                                            fontSize:
                                                14.sp,
                                          ),
                                      hintStyle: TextStyle(
                                        color: AppColors
                                            .grey
                                            .withOpacity(
                                              0.7,
                                            ),
                                        fontSize: 14.sp,
                                      ),
                                      errorText:
                                          field.hasError
                                          ? field
                                                .errorText
                                          : null,
                                      contentPadding:
                                          EdgeInsets.symmetric(
                                            horizontal:
                                                14.w,
                                            vertical:
                                                12.h,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                              12.r,
                                            ),
                                        borderSide: BorderSide(
                                          color: AppColors
                                              .grey
                                              .withOpacity(
                                                0.4,
                                              ),
                                          width: 1.2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                              12.r,
                                            ),
                                        borderSide:
                                            const BorderSide(
                                              color:
                                                  AppColors
                                                      .pink,
                                              width: 1.6,
                                            ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                              12.r,
                                            ),
                                        borderSide:
                                            const BorderSide(
                                              color: Colors
                                                  .red,
                                              width: 1.4,
                                            ),
                                      ),
                                      focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                  12.r,
                                                ),
                                            borderSide:
                                                const BorderSide(
                                                  color: Colors
                                                      .red,
                                                  width:
                                                      1.6,
                                                ),
                                          ),
                                      suffixIcon:
                                          cubit.vehicleLicense ==
                                              null
                                          ? const Icon(
                                              Icons
                                                  .file_upload,
                                              color:
                                                  AppColors
                                                      .pink,
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
  }
}
