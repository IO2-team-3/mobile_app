import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/providers/categories_cache_provider.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:mobile_app/views/events_browsing/filtering/categories_selection.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:openapi/openapi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'categories_selection_test.mocks.dart';

@GenerateMocks([CategoriesCacheProvider, SearchQueryProvider])
void main() {
  late MockCategoriesCacheProvider mockCategoriesCacheProvider;
  late MockSearchQueryProvider mockSearchQueryProvider;

  setUp(() {
    mockCategoriesCacheProvider = MockCategoriesCacheProvider();
    mockSearchQueryProvider = MockSearchQueryProvider();
  });

  final categoriesFromProvider = ListBuilder<Category>([
    (CategoryBuilder()
          ..id = 1
          ..name = 'category-1')
        .build(),
    (CategoryBuilder()
          ..id = 2
          ..name = 'category-2')
        .build(),
  ]).build();

  void arrangeCategoriesCacheProviderReturnsCategories() {
    when(mockCategoriesCacheProvider.getAllCategories()).thenAnswer(
      (_) async => Response(
        data: categoriesFromProvider,
        requestOptions: RequestOptions(),
      ),
    );
  }

  void arrangeCategoriesCacheProviderReturnsCategoriesAfterWait() {
    when(mockCategoriesCacheProvider.getAllCategories()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return Response(
          data: categoriesFromProvider, requestOptions: RequestOptions());
    });
  }

  void arrangeSearchQueryProviderReturnsSelectedCategories() {
    when(mockSearchQueryProvider.categories)
        .thenReturn(UnmodifiableListView([]));
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Demo',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CategoriesCacheProvider>(
            create: (context) => mockCategoriesCacheProvider,
          ),
          ChangeNotifierProvider<SearchQueryProvider>(
            create: (context) => mockSearchQueryProvider,
          ),
        ],
        child: const CategoriesSelection(),
      ),
    );
  }

  group('categories selection', () {
    testWidgets('APPLY button is displayed', (widgetTester) async {
      arrangeCategoriesCacheProviderReturnsCategories();

      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.widgetWithText(TextButton, 'APPLY'), findsOneWidget);
    });

    testWidgets('loading indicator is displayed while waiting for categories',
        (widgetTester) async {
      arrangeCategoriesCacheProviderReturnsCategoriesAfterWait();
      arrangeSearchQueryProviderReturnsSelectedCategories();

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pump(const Duration(milliseconds: 500));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.pumpAndSettle();
    });

    testWidgets('categories are displayed', (widgetTester) async {
      arrangeCategoriesCacheProviderReturnsCategories();
      arrangeSearchQueryProviderReturnsSelectedCategories();

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pump();

      for (final category in categoriesFromProvider) {
        expect(find.text(category.name), findsOneWidget);
      }
    });

    testWidgets('close button is displayed', (widgetTester) async {
      arrangeCategoriesCacheProviderReturnsCategories();
      arrangeSearchQueryProviderReturnsSelectedCategories();

      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });
}
