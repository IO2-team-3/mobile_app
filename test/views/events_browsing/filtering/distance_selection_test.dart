import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mobile_app/providers/location_provider.dart';
import 'package:mobile_app/views/events_browsing/filtering/distance_selection.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'distance_selection_test.mocks.dart';

@GenerateMocks([LocationProvider])
void main() {
  late MockLocationProvider mockLocationProvider;

  setUp(() {
    mockLocationProvider = MockLocationProvider();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider<LocationProvider>(
        create: (context) => mockLocationProvider,
        child: const Scaffold(
          body: DistanceSelection(),
        ),
      ),
    );
  }

  void arrangeLocationProvider() {
    when(mockLocationProvider.getLocationsFromAddress('invalid address'))
        .thenThrow(const NoResultFoundException());
    when(mockLocationProvider.getLocationsFromAddress(''))
        .thenThrow(const NoResultFoundException());
    when(mockLocationProvider
            .getLocationsFromAddress('1600 Amphiteatre Parkway, Mountain View'))
        .thenAnswer((_) async =>
            [Location(latitude: 0, longitude: 0, timestamp: DateTime(0))]);
  }

  testWidgets('should validate address field', (WidgetTester tester) async {
    arrangeLocationProvider();
    await tester.pumpWidget(createWidgetUnderTest());

    // Empty address
    await tester.tap(find.text('APPLY'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a value'), findsOneWidget);

    // Invalid address
    await tester.enterText(find.byType(TextFormField).first, 'invalid address');
    await tester.tap(find.text('APPLY'));
    await tester.pumpAndSettle();
    expect(find.text('Please re-enter the address in correct format'),
        findsOneWidget);

    // Valid address
    await tester.enterText(find.byType(TextFormField).first,
        '1600 Amphiteatre Parkway, Mountain View');
    await tester.tap(find.text('APPLY'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a value'), findsNothing);
    expect(find.text('Please re-enter the address in correct format'),
        findsNothing);
  });

  testWidgets('should validate distance field', (WidgetTester tester) async {
    arrangeLocationProvider();
    await tester.pumpWidget(createWidgetUnderTest());

    // Empty distance
    await tester.tap(find.text('APPLY'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a correct value'), findsOneWidget);

    // Invalid distance
    await tester.enterText(find.byType(TextFormField).last, '0');
    await tester.tap(find.text('APPLY'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a correct value'), findsOneWidget);

    // Valid distance
    await tester.enterText(find.byType(TextFormField).last, '25');
    await tester.tap(find.text('APPLY'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a correct value'), findsNothing);
  });
}
