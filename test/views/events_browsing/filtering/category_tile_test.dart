import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/views/events_browsing/filtering/category_tile.dart';
import 'package:openapi/openapi.dart';
import 'package:flutter/material.dart';

void main() {
  final categoryFromProvider = (CategoryBuilder()
        ..id = 1
        ..name = 'category-1')
      .build();

  group('category tile', () {
    Widget createWidgetUnderTest(bool isSelected, Category category) {
      return MaterialApp(
        title: 'Demo',
        home: Scaffold(
          body: CategoryTile(isSelected: isSelected, category: category),
        ),
      );
    }

    testWidgets('category name is displayed', (widgetTester) async {
      await widgetTester
          .pumpWidget(createWidgetUnderTest(false, categoryFromProvider));
      expect(find.text(categoryFromProvider.name!), findsOneWidget);
    });

    testWidgets('indicates selection', (widgetTester) async {
      await widgetTester
          .pumpWidget(createWidgetUnderTest(true, categoryFromProvider));

      expect(
          find.byWidgetPredicate((widget) =>
              widget is Text &&
              widget.data == categoryFromProvider.name! &&
              widget.style != null &&
              widget.style!.fontWeight == FontWeight.bold),
          findsOneWidget);
    });
  });
}
