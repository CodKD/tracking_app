import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/forget_password_use_case.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/reset_password_use_case.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/varify_reset_code_use_case.dart';
import 'package:tracking_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:tracking_app/features/forget_password/presentation/pages/forget_password_view.dart';

class MockForgetPasswordUseCase extends Mock implements ForgetPasswordUseCase {}

class MockVerifyResetCodeUseCase extends Mock
    implements VerifyResetCodeUseCase {}

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

void main() {
  group('ForgetPasswordView Widget Tests', () {
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
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(home: child),
      );
    }

    Future<void> pumpTestWidget(WidgetTester tester, Widget widget) async {
      await tester.pumpWidget(createTestApp(child: widget));
      await tester.pumpAndSettle();
    }

    testWidgets('should render ForgetPasswordView with basic components', (
      tester,
    ) async {
      await pumpTestWidget(
        tester,
        BlocProvider.value(
          value: mockViewModel,
          child: const ForgetPasswordView(),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
      expect(find.text('Reset Password'), findsOneWidget);
    });

    testWidgets('should navigate back and reset fields', (tester) async {
      await pumpTestWidget(
        tester,
        BlocProvider.value(
          value: mockViewModel,
          child: const ForgetPasswordView(),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pump();

      expect(mockViewModel.emailController.text.isEmpty, isTrue);
    });
  });
}
