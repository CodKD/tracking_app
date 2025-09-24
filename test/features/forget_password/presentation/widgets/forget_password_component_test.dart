import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/forget_password_use_case.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/reset_password_use_case.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/varify_reset_code_use_case.dart';
import 'package:tracking_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:tracking_app/features/forget_password/presentation/widgets/forget_password_component.dart';

class MockForgetPasswordUseCase extends Mock implements ForgetPasswordUseCase {}

class MockVerifyResetCodeUseCase extends Mock
    implements VerifyResetCodeUseCase {}

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

void main() {
  group('ForgetPasswordComponent Widget Tests', () {
    late ForgetPasswordViewModel mockViewModel;
    late MockForgetPasswordUseCase mockForgetPasswordUseCase;
    late MockVerifyResetCodeUseCase mockVerifyResetCodeUseCase;
    late MockResetPasswordUseCase mockResetPasswordUseCase;

    setUp(() {
      mockForgetPasswordUseCase = MockForgetPasswordUseCase();
      mockVerifyResetCodeUseCase = MockVerifyResetCodeUseCase();
      mockResetPasswordUseCase = MockResetPasswordUseCase();

      getIt.registerFactory<ForgetPasswordUseCase>(
        () => mockForgetPasswordUseCase,
      );
      getIt.registerFactory<VerifyResetCodeUseCase>(
        () => mockVerifyResetCodeUseCase,
      );
      getIt.registerFactory<ResetPasswordUseCase>(
        () => mockResetPasswordUseCase,
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

    tearDown(() {
      getIt.reset();
    });

    Widget createTestApp({required Widget child}) {
      return MaterialApp(home: Scaffold(body: child));
    }

    Future<void> pumpTestWidget(WidgetTester tester, Widget widget) async {
      await tester.pumpWidget(createTestApp(child: widget));
      await tester.pumpAndSettle();
    }

    testWidgets('should render ForgetPasswordComponent with form', (
      tester,
    ) async {
      await pumpTestWidget(
        tester,
        BlocProvider.value(
          value: mockViewModel,
          child: ForgetPasswordComponent(viewModel: mockViewModel),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
      expect(find.text('Forget Password'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Send'), findsOneWidget);
    });

    testWidgets('should enable Send button when email is valid', (
      tester,
    ) async {
      await pumpTestWidget(
        tester,
        BlocProvider.value(
          value: mockViewModel,
          child: ForgetPasswordComponent(viewModel: mockViewModel),
        ),
      );

      final textField = find.byType(TextFormField);
      await tester.enterText(textField, 'test@example.com');
      await tester.pump();

      expect(mockViewModel.forgetPassBtnEnabled, isTrue);
    });
  });
}
