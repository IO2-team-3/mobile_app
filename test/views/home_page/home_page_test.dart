import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/views/home_page/carousel.dart';
import 'package:mobile_app/views/home_page/home_page.dart';

void main() {
  group('home page', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        title: 'Demo',
        home: HomePage(),
      );
    }

    testWidgets('title is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('EventWave'), findsOneWidget);
    });

    testWidgets('motto is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(
          find.text(
              'Creating events, organizing business meetings, throwing parties are all at your fingertips!'),
          findsOneWidget);
    });

    testWidgets('image carousel is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Carousel), findsOneWidget);
    });
  });

  group('app menu', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        title: 'Demo',
        home: AppMenu(),
      );
    }

    testWidgets('events item is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Events'), findsOneWidget);
    });

    testWidgets('my reservations item is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('My reservations'), findsOneWidget);
    });

    testWidgets('EventWave logo is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.image(const AssetImage('assets/img/logo/full.png')),
          findsOneWidget);
    });
  });
}
