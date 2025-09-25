import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/input_formatter/app_regex.dart';
import 'package:tracking_app/core/utils/components/app_text_form_feild.dart';
import 'package:tracking_app/features/auth/apply/presentation/cubit/driver_apply_cubit.dart';

class ApplyFields extends StatefulWidget {
  const ApplyFields({super.key});

  @override
  State<ApplyFields> createState() => _ApplyFieldsState();
}

class _ApplyFieldsState extends State<ApplyFields> {
  bool isPasswordObscureText = true;
  bool isConfirmPasswordObscureText = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverApplyCubit>();
    final countries = ['Egypt', 'UAE', 'KSA'];
    final vehicleTypes = ['Bike', 'Car', 'Truck'];

    return Form(
      key: context.read<DriverApplyCubit>().applyFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            initialValue: cubit.selectedCountry.isEmpty
                ? null
                : cubit.selectedCountry,
            decoration: InputDecoration(
              labelText: context.l10n.Country,
              border: OutlineInputBorder(),
            ),
            items: countries
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (v) {
              if (v == null) return;
              cubit.selectCountry(v);
            },
            validator: (v) =>
                (v == null || v.isEmpty) ? "Please select your country" : null,
          ),
          SizedBox(height: 15),
          AppTextFormFeild(
            controller: context.read<DriverApplyCubit>().firstNameController,
            hintText: context.l10n.FirstName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your first name";
              }
              return null;
            },
          ),
          SizedBox(height: 15),
          AppTextFormFeild(
            controller: context.read<DriverApplyCubit>().lastNameController,
            hintText: context.l10n.LastName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your last name";
              }
              return null;
            },
          ),
          SizedBox(height: 15),
          DropdownButtonFormField<String>(
            initialValue: cubit.selectedVehicleType.isEmpty
                ? null
                : cubit.selectedVehicleType,
            decoration: InputDecoration(
              labelText: context.l10n.VehicleType,
              border: OutlineInputBorder(),
            ),
            items: vehicleTypes
                .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                .toList(),
            onChanged: (v) {
              if (v == null) return;
              cubit.selectVehicleType(v);
            },
            validator: (v) =>
                (v == null || v.isEmpty) ? "Plese select your country" : null,
          ),
          SizedBox(height: 15),
          AppTextFormFeild(
            controller: context
                .read<DriverApplyCubit>()
                .vehicleNumberController,
            hintText: context.l10n.VehicleNumber,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your vehicle number";
              }
              return null;
            },
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () {
              cubit.pickImage();
            },
            child: IgnorePointer(
              child: AppTextFormFeild(
                controller: context
                    .read<DriverApplyCubit>()
                    .vehicleLicenseController,
                hintText: context.l10n.VehicleLicense,
                validator: (value) {
                  if (cubit.pickedImage == null) {
                    return "Please upload your vehicle license image";
                  }
                  return null;
                },
                suffixIcon: const Icon(Icons.file_upload),
              ),
            ),
          ),
          SizedBox(height: 15),
          AppTextFormFeild(
            controller: context.read<DriverApplyCubit>().emailController,
            hintText: context.l10n.Email,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 15),
          AppTextFormFeild(
            controller: context.read<DriverApplyCubit>().phoneNumberController,
            hintText: "Phone Number",
            validator: (value) {
              if (value == null || value.isEmpty
              //!AppRegex.isPhoneNumberValid(value)
              ) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 15),
          AppTextFormFeild(
            controller: context.read<DriverApplyCubit>().nIDController,
            hintText: "National ID",
            validator: (value) {
              if (value == null || value.isEmpty
              //!AppRegex.isPhoneNumberValid(value)
              ) {
                return 'Please enter a valid National ID';
              }
              return null;
            },
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () {
              cubit.pickImage();
            },
            child: IgnorePointer(
              child: AppTextFormFeild(
                controller: TextEditingController(
                  text: cubit.pickedImage != null ? "Image Selected" : "",
                ),
                hintText: "Upload ID Image",
                validator: (value) {
                  if (cubit.pickedImage == null) {
                    return "Please upload your ID image";
                  }
                  return null;
                },
                suffixIcon: const Icon(Icons.file_upload),
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: AppTextFormFeild(
                  isObscureText: isPasswordObscureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordObscureText = !isPasswordObscureText;
                      });
                    },
                  ),
                  controller: context
                      .read<DriverApplyCubit>()
                      .passwordController,
                  hintText: 'Password',
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !AppRegex.isPasswordValid(value)) {
                      return 'Password must be at least 8 characters, include an uppercase letter, number and symbol.';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: AppTextFormFeild(
                  isObscureText: isConfirmPasswordObscureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isConfirmPasswordObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordObscureText =
                            !isConfirmPasswordObscureText;
                      });
                    },
                  ),
                  controller: context
                      .read<DriverApplyCubit>()
                      .confirmPasswordController,
                  hintText: 'Confirm Password',
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !AppRegex.isConfirmPasswordValid(
                          context
                              .read<DriverApplyCubit>()
                              .passwordController
                              .text,
                          value,
                        )) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
