import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tracking_app/core/l10n/app_localizations.dart';
import 'package:tracking_app/features/order_details/presentation/view_model/start_order_cubit.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/order_delivered_successfully.dart';

// ----------------- Mock classes -----------------
class MockOrderDetailsCubit extends Mock implements StartOrderCubit {}

class _TestHttpOverrides extends HttpOverrides {} // disable network requests

void main() {
  late MockOrderDetailsCubit mockCubit;

  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides(); // stop loading images
  });

  setUp(() {
    mockCubit = MockOrderDetailsCubit();
  });

  // ignore: unused_element
  Widget pumpTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: BlocProvider<StartOrderCubit>.value(
        value: mockCubit,
        child: child,
      ),
    );
  }



  testWidgets('should navigate to OrderDeliveredSuccessfully on complete',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        routes: {
          '/success': (_) => const OrderDeliveredSuccessfully(),
        },
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/success');
            },
            child: const Text('Complete'),
          ),
        ),
      ),
    );

    expect(find.text('Complete'), findsOneWidget);
    await tester.tap(find.text('Complete'));
    await tester.pumpAndSettle();

    expect(find.byType(OrderDeliveredSuccessfully), findsOneWidget);
  });
}
