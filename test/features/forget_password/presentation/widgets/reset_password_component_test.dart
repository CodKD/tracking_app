import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/forget_password_use_case.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/reset_password_use_case.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/varify_reset_code_use_case.dart';
import 'package:tracking_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:tracking_app/features/forget_password/presentation/widgets/reset_password_component.dart';

class MockForgetPasswordUseCase extends Mock implements ForgetPasswordUseCase {}

class MockVerifyResetCodeUseCase extends Mock
    implements VerifyResetCodeUseCase {}

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

void main() {
  group('ResetPasswordComponent Widget Tests', () {
    late ForgetPasswordViewModel mockViewModel;
    setUp(() {
      getIt.registerFactory<ForgetPasswordUseCase>(
        () => MockForgetPasswordUseCase(),
      );
      getIt.registerFactory<VerifyResetCodeUseCase>(
        () => MockVerifyResetCodeUseCase(),
      );
      getIt.registerFactory<ResetPasswordUseCase>(
        () => MockResetPasswordUseCase(),
      );
      getIt.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(
          forgetPasswordUseCase: getIt<ForgetPasswordUseCase>(),
          verifyResetCodeUseCase: getIt<VerifyResetCodeUseCase>(),
          resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
        ),
      );
      mockViewModel = getIt<ForgetPasswordViewModel>();
    });

    tearDown(() => getIt.reset());

    Widget createTestApp({required Widget child}) {
      return MaterialApp(
        home: Scaffold(body: SafeArea(child: child)),
      );
    }

    Future<void> pumpTestWidget(WidgetTester tester, Widget widget) async {
      await tester.pumpWidget(createTestApp(child: widget));
      await tester.pumpAndSettle();
    }

    testWidgets('should render ResetPasswordComponent with form', (
      tester,
    ) async {
      await pumpTestWidget(
        tester,
        BlocProvider.value(
          value: mockViewModel,
          child: ResetPasswordComponent(viewModel: mockViewModel),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
      expect(find.text('Reset Password'), findsNWidgets(2));
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byIcon(Icons.visibility), findsNWidgets(2));
    });

    testWidgets('should toggle password visibility', (tester) async {
      await pumpTestWidget(
        tester,
        BlocProvider.value(
          value: mockViewModel,
          child: ResetPasswordComponent(viewModel: mockViewModel),
        ),
      );

      await tester.tap(find.byIcon(Icons.visibility).first);
      await tester.pump();
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });
  });
}
