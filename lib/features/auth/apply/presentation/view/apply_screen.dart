import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:tracking_app/core/api_layer/models/request/auth/apply_request.dart';
import 'package:tracking_app/features/auth/apply/domain/usecases/apply_use_case.dart';
import '../cubit/driver_apply_cubit.dart';
import '../cubit/driver_apply_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/image_picker_field.dart';

class DriverApplyScreen extends StatefulWidget {
  const DriverApplyScreen({super.key});

  @override
  State<DriverApplyScreen> createState() => _DriverApplyScreenState();
}

class _DriverApplyScreenState extends State<DriverApplyScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _vehicleNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedCountry;
  String? _selectedVehicleType;
  String? _selectedGender;

  String? _licenseImg;
  String? _nidImg;
  final sl = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Apply")),
      body: BlocProvider(
        create: (_) => DriverApplyCubit(sl<ApplyUseCase>()),
        child: BlocConsumer<DriverApplyCubit, DriverApplyState>(
          listener: (context, state) {
            if (state is DriverApplyError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is DriverApplySuccess) {
              Navigator.pushReplacementNamed(context, "/login");
            }
          },
          builder: (context, state) {
            if (state is DriverApplyLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome!",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                    Text(
                      '''You want to be a delivery man?
Join our team ''',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 12),

                    CustomDropdown(
                      label: "Country",
                      items: const ["Egypt", "UAE", "KSA"],
                      value: _selectedCountry,
                      onChanged: (v) => setState(() => _selectedCountry = v),
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      controller: _firstNameController,
                      label: "First legal name",
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      controller: _secondNameController,
                      label: "Second legal name",
                    ),
                    const SizedBox(height: 12),
                    CustomDropdown(
                      label: "Vehicle Type",
                      items: const ["Car", "Motorbike", "Truck"],
                      value: _selectedVehicleType,
                      onChanged: (v) =>
                          setState(() => _selectedVehicleType = v),
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      controller: _vehicleNameController,
                      label: "Vehicle Number",
                    ),
                    const SizedBox(height: 12),

                    ImagePickerField(
                      label: "License Car Photo",
                      onImagePicked: (file) => setState(() => _licenseImg = ""),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      controller: _emailController,
                      label: "Email",
                      isEmail: true,
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      controller: _idController,
                      label: "ID number",
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      controller: _phoneController,
                      label: "Phone number",
                      isPhone: true,
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      controller: _passwordController,
                      label: "Password",
                      isPassword: true,
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      controller: _confirmPasswordController,
                      label: "Confirm Password",
                      isPassword: true,
                    ),

                    const SizedBox(height: 12),

                    const SizedBox(height: 12),

                    CustomDropdown(
                      label: "Gender",
                      items: const ["Male", "Female"],
                      value: _selectedGender,
                      onChanged: (v) => setState(() => _selectedGender = v),
                    ),

                    const SizedBox(height: 12),

                    ImagePickerField(
                      label: "ID Photo",
                      onImagePicked: (file) => setState(() => _nidImg = ""),
                    ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Passwords do not match"),
                              ),
                            );
                            return;
                          }
                          if (_licenseImg == null || _nidImg == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please upload all images"),
                              ),
                            );
                            return;
                          }

                          final request = ApplyRequest(
                            firstName: _firstNameController.text,
                            lastName: _secondNameController.text,
                            vehicleNumber: _vehicleNameController.text,
                            email: _emailController.text,
                            nID: _idController.text,
                            phone: _phoneController.text,
                            password: _passwordController.text,
                            rePassword: _confirmPasswordController.text,
                            country: _selectedCountry!,
                            vehicleType: _selectedVehicleType!,
                            gender: _selectedGender!,
                            vehicleLicense: _licenseImg!,
                            nIDImg: _nidImg!,
                          );

                          context.read<DriverApplyCubit>().submit(request);
                        }
                      },
                      child: const Text("Submit"),
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
