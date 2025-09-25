import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/input_formatter/app_regex.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/core/utils/components/app_text_form_feild.dart';
import 'package:tracking_app/features/auth/apply/presentation/cubit/driver_apply_cubit.dart';

class ApplyFields extends StatelessWidget {
  const ApplyFields({super.key, required this.cubit});

  final DriverApplyCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.applyFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            initialValue: cubit.selectedCountry.isEmpty
                ? null
                : cubit.selectedCountry,
            decoration: InputDecoration(
              labelText: context.l10n.country,
              border: OutlineInputBorder(),
            ),

            items: cubit.countries
                .map(
                  (c) => DropdownMenuItem(
                    value: c.name,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Country flag
                        SvgPicture.network(
                          c.image,
                          width: 48.w,
                          fit: BoxFit.cover,
                          placeholderBuilder: (context) => Container(
                            width: 24.w,
                            height: 16.h,
                            color: AppColors.grey,
                            child: Icon(
                              Icons.flag,
                              size: 12,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        15.widthBox,
                        // Country name (truncated if too long)
                        Flexible(
                          child: Text(
                            c.name.length > 20
                                ? '${c.name.substring(0, 20)}...'
                                : c.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v == null) return;
              cubit.selectCountry(v);
            },
            validator: (v) => (v == null || v.isEmpty)
                ? context.l10n.descriptionCountry
                : null,
          ),
          15.heightBox,
          AppTextFormFeild(
            controller: context.read<DriverApplyCubit>().firstNameController,
            hintText: context.l10n.enter_first_name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.l10n.descriptionFirstName;
              }
              if (value.length < 2) {
                return "Name must be at least 2 characters";
              }
              return null;
            },
            labelTxt: context.l10n.first_name,
          ),
          15.heightBox,
          AppTextFormFeild(
            controller: context.read<DriverApplyCubit>().lastNameController,
            hintText: context.l10n.enter_last_name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.l10n.descriptionLastName;
              }
              if (value.length < 2) {
                return "Name must be at least 2 characters";
              }
              return null;
            },
            labelTxt: context.l10n.last_name,
          ),
          15.heightBox,
          DropdownButtonFormField<String>(
            initialValue: cubit.selectedVehicleType.isEmpty
                ? null
                : cubit.selectedVehicleType,
            decoration: InputDecoration(
              labelText: context.l10n.vehicle_type,
              labelStyle: TextStyle(color: AppColors.grey, fontSize: 14.sp),
              border: OutlineInputBorder(),
            ),
            items: cubit.vehicleTypes
                .map(
                  (d) => DropdownMenuItem(
                    value: d,
                    child: Text(d, style: TextStyle(fontSize: 14.sp)),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v == null) return;
              cubit.selectVehicleType(v);
            },
            validator: (v) => (v == null || v.isEmpty)
                ? context.l10n.descriptionCountry
                : null,
          ),
          15.heightBox,
          AppTextFormFeild(
            controller: context
                .read<DriverApplyCubit>()
                .vehicleNumberController,
            hintText: context.l10n.vehicle_number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.l10n.descriptionVehicleNumber;
              }
              return null;
            },
          ),
          15.heightBox,
          BlocBuilder<DriverApplyCubit, DriverApplyState>(
            builder: (context, state) {
              return FormField<File>(
                validator: (value) {
                  if (cubit.vehicleLicense == null) {
                    return context.l10n.uploadVehicleLicenseError;
                  }
                  return null;
                },
                builder: (field) {
                  return InkWell(
                    onTap: () {
                      cubit.pickVehicleLicenseImage();
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: context.l10n.vehicle_license,
                          labelStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14.sp,
                          ),
                          border: OutlineInputBorder(),
                          errorText: field.hasError ? field.errorText : null,
                          suffixIcon: cubit.vehicleLicense == null
                              ? Icon(Icons.file_upload)
                              : IconButton(
                                  icon: Icon(Icons.close, color: Colors.red),
                                  onPressed: () {
                                    cubit.clearVehicleLicense();
                                  },
                                ),
                        ),
                        readOnly: true,
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 12.sp,
                          backgroundColor: cubit.vehicleLicense != null
                              ? AppColors.pink.shade200
                              : Colors.transparent,
                        ),
                        controller: TextEditingController(
                          text: cubit.vehicleLicense != null
                              ? cubit.getFileName(cubit.vehicleLicense!.path)
                              : '',
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          15.heightBox,
          AppTextFormFeild(
            controller: context.read<DriverApplyCubit>().emailController,
            hintText: context.l10n.email,
            keyboardType: TextInputType.emailAddress,

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
          15.heightBox,
          AppTextFormFeild(
            controller: context.read<DriverApplyCubit>().phoneNumberController,
            keyboardType: TextInputType.numberWithOptions(decimal: false),

            hintText: context.l10n.phoneNumber,
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
          15.heightBox,
          AppTextFormFeild(
            controller: context.read<DriverApplyCubit>().nIDController,
            hintText: context.l10n.nID,
            keyboardType: TextInputType.numberWithOptions(decimal: false),

            validator: (value) {
              if (value == null || value.isEmpty
              //!AppRegex.isPhoneNumberValid(value)
              ) {
                return context.l10n.descriptionNId;
              }
              if (!AppRegex.isNIDValid(value)) {
                return context.l10n.nationalIdError;
              }
              return null;
            },
          ),
          SizedBox(height: 15),
          BlocBuilder<DriverApplyCubit, DriverApplyState>(
            builder: (context, state) {
              return FormField<File>(
                validator: (value) {
                  if (cubit.nIDImg == null) {
                    return context.l10n.uploadIdError;
                  }
                  return null;
                },
                builder: (field) {
                  return InkWell(
                    onTap: () {
                      cubit.pickNIDImage();
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: context.l10n.n_iD_img,
                          labelStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14.sp,
                          ),
                          border: OutlineInputBorder(),
                          errorText: field.hasError ? field.errorText : null,
                          suffixIcon: cubit.nIDImg == null
                              ? Icon(Icons.file_upload)
                              : IconButton(
                                  icon: Icon(Icons.close, color: Colors.red),
                                  onPressed: () {
                                    cubit.clearNIDImage();
                                  },
                                ),
                        ),
                        readOnly: true,
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 12.sp,
                          backgroundColor: cubit.nIDImg != null
                              ? AppColors.pink.shade200
                              : Colors.transparent,
                        ),
                        controller: TextEditingController(
                          text: cubit.nIDImg != null
                              ? cubit.getFileName(cubit.nIDImg!.path)
                              : '',
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          15.heightBox,
          BlocBuilder<DriverApplyCubit, DriverApplyState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: AppTextFormFeild(
                      isObscureText: cubit.isPasswordObscureText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          cubit.isPasswordObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          cubit.changePasswordVisibility();
                        },
                      ),
                      controller: cubit.passwordController,
                      hintText: context.l10n.password,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !AppRegex.isPasswordValid(value)) {
                          return context.l10n.passwordError;
                        }
                        if (!AppRegex.isPasswordValid(value)) {
                          return context.l10n.passwordError;
                        }
                        return null;
                      },
                    ),
                  ),
                  10.widthBox,
                  Expanded(
                    child: AppTextFormFeild(
                      isObscureText: cubit.isConfirmPasswordObscureText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          cubit.isConfirmPasswordObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          cubit.changeConfirmPasswordVisibility();
                        },
                      ),
                      controller: cubit.confirmPasswordController,
                      hintText: context.l10n.confirmPassword,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !AppRegex.isConfirmPasswordValid(
                              cubit.passwordController.text,
                              value,
                            )) {
                          return context.l10n.confirmPasswordError;
                        }
                        if (value != cubit.passwordController.text) {
                          return context.l10n.confirmPasswordError;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          15.heightBox,
        ],
      ),
    );
  }
}
