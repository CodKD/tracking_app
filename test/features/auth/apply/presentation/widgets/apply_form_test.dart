import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: deprecated_member_use
import 'package:mocktail/mocktail.dart';
import 'package:tracking_app/features/auth/apply/presentation/cubit/driver_apply_cubit.dart';
import 'package:tracking_app/features/auth/apply/presentation/widgets/apply_form.dart';

class MockDriverApplyCubit extends Mock implements DriverApplyCubit {}

void main() {
  late MockDriverApplyCubit mockCubit;

  setUp(() {
    mockCubit = MockDriverApplyCubit();

    // stubs
    when(() => mockCubit.applyFormKey).thenReturn(GlobalKey<FormState>());
    when(() => mockCubit.selectedCountry).thenReturn('');
    when(() => mockCubit.countries).thenReturn([]);
    when(() => mockCubit.selectedVehicleType).thenReturn('');
    when(() => mockCubit.vehicleTypes).thenReturn(['Car', 'Bike']);
    when(() => mockCubit.vehicleLicense).thenReturn(null);
    when(() => mockCubit.nIDImg).thenReturn(null);

    // text controllers
    when(
      () => mockCubit.firstNameController,
    ).thenReturn(TextEditingController());
    when(
      () => mockCubit.lastNameController,
    ).thenReturn(TextEditingController());
    when(
      () => mockCubit.vehicleNumberController,
    ).thenReturn(TextEditingController());
    when(() => mockCubit.emailController).thenReturn(TextEditingController());
    when(
      () => mockCubit.phoneNumberController,
    ).thenReturn(TextEditingController());
    when(() => mockCubit.nIDController).thenReturn(TextEditingController());
    when(
      () => mockCubit.passwordController,
    ).thenReturn(TextEditingController());
    when(
      () => mockCubit.confirmPasswordController,
    ).thenReturn(TextEditingController());

    when(() => mockCubit.isPasswordObscureText).thenReturn(true);
    when(() => mockCubit.isConfirmPasswordObscureText).thenReturn(true);

    // actions
    when(() => mockCubit.selectCountry(any())).thenAnswer((_) async {});
    when(() => mockCubit.selectVehicleType(any())).thenAnswer((_) async {});
    when(() => mockCubit.pickVehicleLicenseImage()).thenAnswer((_) async {});
    when(() => mockCubit.clearVehicleLicense()).thenAnswer((_) async {});
    when(() => mockCubit.pickNIDImage()).thenAnswer((_) async {});
    when(() => mockCubit.clearNIDImage()).thenAnswer((_) async {});
    when(() => mockCubit.changePasswordVisibility()).thenAnswer((_) async {});
    when(
      () => mockCubit.changeConfirmPasswordVisibility(),
    ).thenAnswer((_) async {});
  });

  Widget buildTestable(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: BlocProvider<DriverApplyCubit>.value(
            value: mockCubit,
            child: child,
          ),
        ),
      ),
    );
  }

  testWidgets('renders all fields', (tester) async {
    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));

    expect(find.byType(Form), findsOneWidget);
    expect(
      find.byType(DropdownButtonFormField<String>),
      findsNWidgets(2),
    ); // country + vehicleType
    expect(find.textContaining('first'), findsWidgets);
    expect(find.textContaining('last'), findsWidgets);
    expect(find.textContaining('email'), findsWidgets);
    expect(find.textContaining('phone'), findsWidgets);
    expect(find.textContaining('password'), findsWidgets);
    expect(find.textContaining('confirm'), findsWidgets);
    expect(find.textContaining('vehicle'), findsWidgets);
    expect(find.textContaining('nID'), findsWidgets);
  });

  testWidgets('validates empty firstName', (tester) async {
    final formKey = GlobalKey<FormState>();
    when(() => mockCubit.applyFormKey).thenReturn(formKey);
    when(
      () => mockCubit.firstNameController,
    ).thenReturn(TextEditingController());

    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));
    formKey.currentState!.validate();
    await tester.pump();

    expect(find.textContaining('at least'), findsOneWidget);
  });

  testWidgets('validates invalid email', (tester) async {
    final controller = TextEditingController(text: 'wrongEmail');
    when(() => mockCubit.emailController).thenReturn(controller);

    final formKey = GlobalKey<FormState>();
    when(() => mockCubit.applyFormKey).thenReturn(formKey);

    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));
    formKey.currentState!.validate();
    await tester.pump();

    expect(find.textContaining('email'), findsWidgets);
  });

  testWidgets('validates phone regex', (tester) async {
    final controller = TextEditingController(text: '123');
    when(() => mockCubit.phoneNumberController).thenReturn(controller);

    final formKey = GlobalKey<FormState>();
    when(() => mockCubit.applyFormKey).thenReturn(formKey);

    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));
    formKey.currentState!.validate();
    await tester.pump();

    expect(find.textContaining('valid'), findsWidgets);
  });

  testWidgets('validates NID regex', (tester) async {
    final controller = TextEditingController(text: '12');
    when(() => mockCubit.nIDController).thenReturn(controller);

    final formKey = GlobalKey<FormState>();
    when(() => mockCubit.applyFormKey).thenReturn(formKey);

    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));
    formKey.currentState!.validate();
    await tester.pump();

    expect(find.textContaining('national'), findsWidgets);
  });

  testWidgets('shows error if vehicleLicense not picked', (tester) async {
    final formKey = GlobalKey<FormState>();
    when(() => mockCubit.applyFormKey).thenReturn(formKey);

    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));
    formKey.currentState!.validate();
    await tester.pump();

    expect(find.textContaining('license'), findsWidgets);
  });

  testWidgets('shows error if NID image not picked', (tester) async {
    final formKey = GlobalKey<FormState>();
    when(() => mockCubit.applyFormKey).thenReturn(formKey);

    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));
    formKey.currentState!.validate();
    await tester.pump();

    expect(find.textContaining('Id'), findsWidgets);
  });

  testWidgets('validates password mismatch', (tester) async {
    final passCtrl = TextEditingController(text: 'Pass1234');
    final confirmCtrl = TextEditingController(text: 'Different');
    when(() => mockCubit.passwordController).thenReturn(passCtrl);
    when(() => mockCubit.confirmPasswordController).thenReturn(confirmCtrl);

    final formKey = GlobalKey<FormState>();
    when(() => mockCubit.applyFormKey).thenReturn(formKey);

    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));
    formKey.currentState!.validate();
    await tester.pump();

    expect(find.textContaining('confirm'), findsWidgets);
  });

  testWidgets('calls selectVehicleType when dropdown changed', (tester) async {
    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));

    await tester.tap(find.byType(DropdownButtonFormField<String>).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Car').last);
    await tester.pump();

    verify(() => mockCubit.selectVehicleType('Car')).called(1);
  });

  testWidgets('calls pickVehicleLicenseImage when tapped', (tester) async {
    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));
    await tester.tap(find.textContaining('license').last);
    await tester.pump();

    verify(() => mockCubit.pickVehicleLicenseImage()).called(1);
  });

  testWidgets('calls pickNIDImage when tapped', (tester) async {
    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));
    await tester.tap(find.textContaining('n_iD_img').last);
    await tester.pump();

    verify(() => mockCubit.pickNIDImage()).called(1);
  });

  testWidgets('toggles password visibility', (tester) async {
    await tester.pumpWidget(buildTestable(ApplyFields(cubit: mockCubit)));

    await tester.tap(find.byIcon(Icons.visibility_off).first);
    await tester.pump();

    verify(() => mockCubit.changePasswordVisibility()).called(1);
  });
}
