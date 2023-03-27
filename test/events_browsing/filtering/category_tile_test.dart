import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/providers/categories_cache_provider.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:mobile_app/views/events_browsing/filtering/categories_selection.dart';
import 'package:mobile_app/views/events_browsing/filtering/category_tile.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:openapi/openapi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'categories_selection_test.mocks.dart';

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
