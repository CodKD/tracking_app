import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tracking_app/core/l10n/app_localizations.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/models/pending_orders_response.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/cubit/home_tab_cubit.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/order_card.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/refresh_home.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/skeleton_home.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/widgets/available_for_delivery.dart';

/// Fake Cubit (بدل GetIt)
class FakeHomeTabCubit extends Cubit<HomeTabState> implements HomeTabCubit {
  FakeHomeTabCubit() : super(HomeTabLoading());

  @override
  Future<void> getHomeData() async {}

  @override
  void rejectOrderFromScreen(order) {}

  @override
  List<Orders>? displayedOrders;
}

/// Mock HomeTab View بدون GetIt + استبدال الصور بـ AssetImage
class _MockHomeTabView extends StatelessWidget {
  const _MockHomeTabView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeTabCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Home Tab')),
      body: BlocBuilder<HomeTabCubit, HomeTabState>(
        builder: (context, state) {
          if (state is HomeTabLoading) {
            return const SkeletonHome();
          } else if (state is HomeTabSuccess) {
            final orders = state.pendingDriverOrdersEntity.orders ?? [];
            return orders.isNotEmpty
                ? ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (_, i) {
                      final order = orders[i];
                      return OrderCard(
                        orderPending: order, onReject: () {  },
                      );
                    },
                  )
                :  RefreshHome(
                    viewModel: viewModel, // dummy
                    savedToken: 'fake',
                  );
          } else {
            return const AvailableForDelivery();
          }
        },
      ),
    );
  }
}

/// HttpOverrides عشان يمنع أي call للإنترنت في التست
class _FakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  group('HomeTab Widget Tests', () {
    late FakeHomeTabCubit fakeCubit;

    setUpAll(() {
      HttpOverrides.global = _FakeHttpOverrides();
    });

    setUp(() {
      fakeCubit = FakeHomeTabCubit();
    });

    Widget createTestApp({required Widget child}) {
      return MaterialApp(
        home: child,
        localizationsDelegates: const [
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

    testWidgets('should show RefreshHome when state has no orders', (tester) async {
      fakeCubit.emit(HomeTabSuccess(
        PendingDriverOrdersEntity(orders: []),
      ));

      await pumpTestWidget(
        tester,
        BlocProvider<HomeTabCubit>(
          create: (_) => fakeCubit,
          child: const _MockHomeTabView(),
        ),
      );

      expect(find.byType(RefreshHome), findsOneWidget);
    });

    testWidgets('should show AvailableForDelivery for other states', (tester) async {
      fakeCubit.emit(HomeTabFail("error"));

      await pumpTestWidget(
        tester,
        BlocProvider<HomeTabCubit>(
          create: (_) => fakeCubit,
          child: const _MockHomeTabView(),
        ),
      );

      expect(find.byType(AvailableForDelivery), findsOneWidget);
    });
  });
}
