import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:tracking_app/features/profile/presentation/widgets/profile_body.dart';
import 'package:tracking_app/features/profile/presentation/view_model/cubit.dart';

class MockProfileCubit extends Mock implements ProfileCubit {}

class FakeProfileState extends Fake {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeProfileState());
  });

  late ProfileCubit mockCubit;

  setUp(() {
    mockCubit = MockProfileCubit();
  });

  Widget makeTestableWidget(
    Widget child,
    ProfileCubit cubit,
    ProfileState state,
  ) {
    when(() => cubit.state).thenReturn(state);
    return MaterialApp(
      home: BlocProvider<ProfileCubit>.value(value: cubit, child: child),
    );
  }

  testWidgets(
    'shows loading indicator when state is GetLoggedDriverDataLoading',
    (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          const ProfileBody(),
          mockCubit,
          GetLoggedDriverDataLoading(),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets('shows error message when state is GetLoggedDriverDataError', (
    tester,
  ) async {
    const errorMessage = 'Error occurred';
    await tester.pumpWidget(
      makeTestableWidget(
        const ProfileBody(),
        mockCubit,
        GetLoggedDriverDataError(message: errorMessage),
      ),
    );
    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('shows profile info when state is GetLoggedDriverDataSuccess', (
    tester,
  ) async {
    final driver = ProfileDriverEntity(
      firstName: 'Marwan',
      lastName: 'yasser',
      email: 'marwan@example.com',
      phone: '123456789',
      photo: null,
      vehicleType: '0x01',
      vehicleNumber: 'ABC123',
    );
    await tester.pumpWidget(
      makeTestableWidget(
        const ProfileBody(),
        mockCubit,
        GetLoggedDriverDataSuccess(driver: driver),
      ),
    );
    expect(find.text('Marwna Yasser'), findsOneWidget);
    expect(find.text('marwan@example.com'), findsOneWidget);
    expect(find.text('123456789'), findsOneWidget);
    expect(find.text('Vehicle info'), findsOneWidget);
    expect(find.text('ABC123'), findsOneWidget);
  });
}
