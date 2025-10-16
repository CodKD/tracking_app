// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:tracking_app/features/profile/presentation/widgets/app_bar_profile.dart';
// import 'package:tracking_app/core/l10n/app_localizations.dart';

// void main() {
//   testWidgets('AppBarProfile displays title and notification badge', (
//     WidgetTester tester,
//   ) async {
//     await tester.pumpWidget(
//       const MaterialApp(
//         localizationsDelegates: AppLocalizations.localizationsDelegates,
//         supportedLocales: [Locale('en')],
//         home: Scaffold(body: AppBarProfile()),
//       ),
//     );

//     // Check for the profile title
//     expect(find.text('Profile'), findsOneWidget);

//     // Check for the notification icon
//     expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);

//     // Check for the notification badge with '3'
//     expect(find.text('3'), findsOneWidget);

//     // Check for the back button icon
//     expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
//   });
// }
