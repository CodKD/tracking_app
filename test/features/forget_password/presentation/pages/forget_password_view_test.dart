import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
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
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/features/forget_password/presentation/widgets/forget_password_component.dart';
import 'package:tracking_app/features/forget_password/presentation/widgets/otp_component.dart';
import 'package:tracking_app/features/forget_password/presentation/widgets/reset_password_component.dart';

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
  dynamic _mockResponse;

  void setMockResponse(dynamic response) {
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

// Mock version of ForgetPasswordView that doesn't use GetIt
class _MockForgetPasswordView extends StatelessWidget {
  const _MockForgetPasswordView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ForgetPasswordViewModel>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: context.width * 0.04),
          child: IconButton(
            onPressed: () {
              viewModel.resetAllFields();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        leadingWidth: context.width * 0.09,
        title: Text(context.l10n.password, style: AppStyles.appBarTitleStyle),
        centerTitle: false,
      ),
      body: PageView(
        controller: viewModel.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ForgetPasswordComponent(viewModel: viewModel),
          OtpComponent(viewModel: viewModel),
          ResetPasswordComponent(viewModel: viewModel),
        ],
      ),
    );
  }
}

void main() {
  group('ForgetPasswordView Widget Tests', () {
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
      // Don't dispose here as the widget will handle disposal
    });

    Widget createTestApp({required Widget child}) {
      return MaterialApp(
        home: child,
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

    testWidgets('should render ForgetPasswordView with basic components', (
      tester,
    ) async {
      await pumpTestWidget(
        tester,
        BlocProvider<ForgetPasswordViewModel>(
          create: (context) => mockViewModel,
          child: const _MockForgetPasswordView(),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets('should have back button in app bar', (tester) async {
      await pumpTestWidget(
        tester,
        BlocProvider<ForgetPasswordViewModel>(
          create: (context) => mockViewModel,
          child: const _MockForgetPasswordView(),
        ),
      );

      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
    });
  });
}
