import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tracking_app/core/utils/language_cubit.dart';
import 'package:tracking_app/features/profile/presentation/widgets/list_tile_header.dart';

class MockLocaleCubit extends Mock implements LocaleCubit {}

void main() {
  late MockLocaleCubit mockLocaleCubit;

  setUp(() {
    mockLocaleCubit = MockLocaleCubit();
  });

  Widget createWidgetUnderTest({required String locale}) {
    return MaterialApp(
      locale: Locale(locale),
      home: BlocProvider<LocaleCubit>.value(
        value: mockLocaleCubit,
        child: const Scaffold(body: ListTileHeader()),
      ),
    );
  }

  testWidgets('renders language ListTile and toggles language', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(locale: 'en'));

    expect(find.text('Language'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.translate));
    await tester.pumpAndSettle();

    verify(() => mockLocaleCubit.changeLang('ar')).called(1);
  });

  testWidgets('renders logout ListTile', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(locale: 'en'));

    expect(find.byIcon(Icons.logout_outlined), findsNWidgets(2));
    expect(find.textContaining('logout', findRichText: true), findsOneWidget);
  });
}
