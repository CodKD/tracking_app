import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import 'package:tracking_app/core/l10n/app_localizations.dart';
import 'package:tracking_app/features/orders/presentation/manager/my_orders_view_model.dart';
import 'package:tracking_app/features/orders/presentation/manager/my_orders_state.dart';
import 'package:tracking_app/features/orders/presentation/pages/orders_view.dart';
import 'package:tracking_app/features/orders/domain/entities/my_orders_entity.dart';

class MockMyOrdersViewModel extends Mock implements MyOrdersViewModel {
  @override
  Future<void> close() async {}
}

class _TestHttpOverrides extends HttpOverrides {}

void main() {
  late MockMyOrdersViewModel mockViewModel;
  final getIt = GetIt.instance;

  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  setUp(() {
    mockViewModel = MockMyOrdersViewModel();
    getIt.registerFactory<MyOrdersViewModel>(() => mockViewModel);
  });

  tearDown(() {
    getIt.reset();
  });

  Widget pumpTestWidget() {
    return const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en')],
      home: OrdersView(),
    );
  }


  testWidgets('should display error on error state', (tester) async {
    when(() => mockViewModel.state).thenReturn(MyOrdersError('Error'));
    when(() => mockViewModel.stream)
        .thenAnswer((_) => Stream.value(MyOrdersError('Error')));
    when(() => mockViewModel.getMyOrders()).thenAnswer((_) async {});

    await tester.pumpWidget(pumpTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('should display orders on success state', (tester) async {
    final entity = MyOrdersEntity(orders: []);
    when(() => mockViewModel.state).thenReturn(MyOrdersSuccess(entity));
    when(() => mockViewModel.stream)
        .thenAnswer((_) => Stream.value(MyOrdersSuccess(entity)));
    when(() => mockViewModel.getMyOrders()).thenAnswer((_) async {});

    await tester.pumpWidget(pumpTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Recent orders'), findsOneWidget);
  });
}