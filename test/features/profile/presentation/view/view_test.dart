// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:tracking_app/features/profile/presentation/view/view.dart';
// import 'package:tracking_app/features/profile/presentation/view_model/cubit.dart';
// import 'package:tracking_app/features/profile/presentation/widgets/app_bar_profile.dart';
// import 'package:tracking_app/features/profile/presentation/widgets/profile_body.dart';

// class MockProfileCubit extends Mock implements ProfileCubit {}

// void main() {
//   late ProfileCubit mockCubit;

//   setUp(() {
//     mockCubit = MockProfileCubit();
//     when(
//       () => mockCubit.getLoggedDriverData(),
//     ).thenReturn(mockCubit as Future<void>);
//   });

//   testWidgets('ProfileTab renders AppBarProfile and ProfileBody', (
//     WidgetTester tester,
//   ) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider<ProfileCubit>.value(
//           value: mockCubit,
//           child: const ProfileTab(),
//         ),
//       ),
//     );

//     expect(find.byType(AppBarProfile), findsOneWidget);
//     expect(find.byType(ProfileBody), findsOneWidget);
//   });
// }
