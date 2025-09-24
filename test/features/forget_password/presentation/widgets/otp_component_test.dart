import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tracking_app/core/l10n/app_localizations.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/forget_password/domain/entities/forget_password_response_entity.dart';
import 'package:tracking_app/features/forget_password/domain/entities/reset_password_response_entity.dart';
import 'package:tracking_app/features/forget_password/domain/entities/verify_reset_code_entity.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/forget_password_use_case.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/reset_password_use_case.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/varify_reset_code_use_case.dart';
import 'package:tracking_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:tracking_app/features/forget_password/presentation/widgets/otp_component.dart';

// Manual mock classes
class FakeForgetPasswordUseCase implements ForgetPasswordUseCase {
  ApiResult<ForgetPasswordResponseEntity>? _mockResponse;

  void setMockResponse(ApiResult<ForgetPasswordResponseEntity> response) {
    _mockResponse = response;
  }

  @override
  Future<ApiResult<ForgetPasswordResponseEntity>> call({
    required String email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockResponse ?? ApiErrorResult('No mock response set');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeVerifyResetCodeUseCase implements VerifyResetCodeUseCase {
  ApiResult<VerifyResetCodeResponseEntity>? _mockResponse;

  void setMockResponse(ApiResult<VerifyResetCodeResponseEntity> response) {
    _mockResponse = response;
  }

  @override
  Future<ApiResult<VerifyResetCodeResponseEntity>> call({
    required String resetCode,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockResponse ?? ApiErrorResult('No mock response set');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeResetPasswordUseCase implements ResetPasswordUseCase {
  ApiResult<ResetPasswordResponseEntity>? _mockResponse;

  void setMockResponse(ApiResult<ResetPasswordResponseEntity> response) {
    _mockResponse = response;
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> call({
    required String email,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockResponse ?? ApiErrorResult('No mock response set');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('OtpComponent Widget Tests', () {
    late ForgetPasswordViewModel mockViewModel;
    late FakeForgetPasswordUseCase fakeForgetPasswordUseCase;
    late FakeVerifyResetCodeUseCase fakeVerifyResetCodeUseCase;
    late FakeResetPasswordUseCase fakeResetPasswordUseCase;

    setUp(() {
      fakeForgetPasswordUseCase = FakeForgetPasswordUseCase();
      fakeVerifyResetCodeUseCase = FakeVerifyResetCodeUseCase();
      fakeResetPasswordUseCase = FakeResetPasswordUseCase();

      mockViewModel = ForgetPasswordViewModel(
        forgetPasswordUseCase: fakeForgetPasswordUseCase,
        verifyResetCodeUseCase: fakeVerifyResetCodeUseCase,
        resetPasswordUseCase: fakeResetPasswordUseCase,
      );
    });

    tearDown(() {
      // Don't dispose here as the widget handles disposal
    });

    Widget createTestApp({required Widget child}) {
      return MaterialApp(
        home: Scaffold(body: SafeArea(child: child)),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
      );
    }

    Future<void> pumpTestWidget(WidgetTester tester, Widget widget) async {
      await tester.pumpWidget(createTestApp(child: widget));
      await tester.pumpAndSettle();
    }

    testWidgets('should render OtpComponent with 6 input fields', (
      tester,
    ) async {
      await pumpTestWidget(
        tester,
        BlocProvider.value(
          value: mockViewModel,
          child: OtpComponent(viewModel: mockViewModel),
        ),
      );

      expect(find.text('Email Verification'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(6));
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('should enable Continue button when OTP is valid', (
      tester,
    ) async {
      await pumpTestWidget(
        tester,
        BlocProvider.value(
          value: mockViewModel,
          child: OtpComponent(viewModel: mockViewModel),
        ),
      );

      for (int i = 0; i < 6; i++) {
        await tester.enterText(find.byType(TextFormField).at(i), '1');
      }
      await tester.pump();
      expect(mockViewModel.otpBtnEnabled, isTrue);
    });
  });
}
