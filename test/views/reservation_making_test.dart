import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/views/reservation_making.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import 'reservation_making_test.mocks.dart';

@GenerateMocks([APIProvider])
void main() {
  late MockAPIProvider mockApiProvider;
  setUp(() {
    mockApiProvider = MockAPIProvider();
  });

  final eventWithPlacesBuilder = EventWithPlacesBuilder();
  final categoryBuilder = CategoryBuilder();
  final placeBuilder = PlaceBuilder();
  final eventWithPlacesFromProvider = (eventWithPlacesBuilder
        ..id = 1
        ..title = 'test event with places'
        ..startTime = 0
        ..endTime = 10000
        ..latitude = '12.34'
        ..longitude = '-12.56'
        ..name = 'test event with places name'
        ..status = EventStatus.inFuture
        ..categories = ListBuilder<Category>([
          (categoryBuilder
                ..id = 1
                ..name = 'category-name')
              .build(),
        ])
        ..freePlace = 100
        ..maxPlace = 1000
        ..placeSchema =
            'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAIAQMAAAD+wSzIAAAABlBMVEX///+/v7+jQ3Y5AAAADklEQVQI12P4AIX8EAgALgAD/aNpbtEAAAAASUVORK5CYII'
        ..places = ListBuilder<Place>([
          (placeBuilder
                ..id = 1
                ..free = true)
              .build(),
          (placeBuilder
                ..id = 2
                ..free = false)
              .build(),
        ]))
      .build();

  void arrangeEventByIdReturnsEvent() {
    when(mockApiProvider.fetchEventById(id: 1)).thenAnswer((_) async =>
        Response(
            data: eventWithPlacesFromProvider,
            requestOptions: RequestOptions()));
  }

  void arrangeEventByIdReturnsEventAfterWait() {
    when(mockApiProvider.fetchEventById(id: 1)).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return Response(
          data: eventWithPlacesFromProvider, requestOptions: RequestOptions());
    });
  }

  void arrangeMakeReservationReturns400() {
    final requestOptions = RequestOptions(method: 'POST', path: '/reservation');
    when(mockApiProvider.makeReservation(eventId: 1)).thenThrow(
      DioError(
        requestOptions: requestOptions,
        type: DioErrorType.badResponse,
        response: Response(requestOptions: requestOptions, statusCode: 400),
      ),
    );
  }

  void arrangeMakeReservationReturns404() {
    final requestOptions = RequestOptions(method: 'POST', path: '/reservation');
    when(mockApiProvider.makeReservation(eventId: 1)).thenThrow(
      DioError(
        requestOptions: requestOptions,
        type: DioErrorType.badResponse,
        response: Response(requestOptions: requestOptions, statusCode: 404),
      ),
    );
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Demo',
      home: ChangeNotifierProvider<APIProvider>(
        create: (context) => mockApiProvider,
        child: const ReservationMaking(
            eventId: 1, address: '68 Testing Street, NYC'),
      ),
    );
  }

  group('reservation making visuals', () {
    testWidgets('title is displayed', (widgetTester) async {
      arrangeEventByIdReturnsEvent();
      await widgetTester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Make a reservation'), findsOneWidget);
    });

    testWidgets('loading indicator is displayed while waiting for event',
        (widgetTester) async {
      arrangeEventByIdReturnsEventAfterWait();

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pump(const Duration(milliseconds: 500));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.pumpAndSettle();
    });

    testWidgets('available places are displayed', (widgetTester) async {
      arrangeEventByIdReturnsEvent();

      await widgetTester.pumpWidget(createWidgetUnderTest());

      await widgetTester.pump();

      for (final place in eventWithPlacesFromProvider.places) {
        if (place.free == true) {
          expect(find.text('Place ${place.id}'), findsOneWidget);
        } else {
          expect(find.text('Place ${place.id}'), findsNothing);
        }
      }
    });

    testWidgets('button text when place selected', (widgetTester) async {
      arrangeEventByIdReturnsEvent();

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byType(ListTile));
      await widgetTester.pump();

      expect(find.text('RESERVE THIS PLACE'), findsOneWidget);
    });

    testWidgets('button text when place not selected', (widgetTester) async {
      arrangeEventByIdReturnsEvent();

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pump();

      expect(find.text('RESERVE ANY PLACE'), findsOneWidget);
    });
  });

  group('error handling', () {
    testWidgets('server returns placeTaken / 400', (widgetTester) async {
      arrangeEventByIdReturnsEvent();
      arrangeMakeReservationReturns400();

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byType(TextButton));
      await widgetTester.pump();

      expect(find.text('Place taken'), findsOneWidget);
    });

    testWidgets('server returns event deleted / 404', (widgetTester) async {
      arrangeEventByIdReturnsEvent();
      arrangeMakeReservationReturns404();

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byType(TextButton));
      await widgetTester.pump();

      expect(find.text('Event does not exist'), findsOneWidget);
    });
  });
}
