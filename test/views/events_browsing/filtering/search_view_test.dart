import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:mobile_app/views/events_browsing/filtering/search_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import 'categories_selection_test.mocks.dart';

@GenerateMocks([SearchQueryProvider])
void main() {
  late SearchView subject;
  late MockSearchQueryProvider mockSearchQueryProvider;

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider<SearchQueryProvider>(
        create: (context) => mockSearchQueryProvider,
        child: Scaffold(
          body: subject,
        ),
      ),
    );
  }

  setUp(() {
    mockSearchQueryProvider = MockSearchQueryProvider();
    subject = const SearchView();
  });

  void arrangeSearchQueryProvider() {
    when(mockSearchQueryProvider.eventName).thenReturn('super event');
    when(mockSearchQueryProvider.categories)
        .thenReturn(UnmodifiableListView<Category>([
      (CategoryBuilder()..name = 'lorem').build(),
      (CategoryBuilder()..name = 'ipsum').build(),
    ]));
    when(mockSearchQueryProvider.distanceInKm).thenReturn(100);
  }

  testWidgets('SearchView has correct title and back button',
      (WidgetTester tester) async {
    arrangeSearchQueryProvider();
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('Find event'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('Text field displays old event name',
      (WidgetTester tester) async {
    arrangeSearchQueryProvider();
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.widgetWithText(TextField, 'super event'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('Text field updates query when text is entered',
      (WidgetTester tester) async {
    arrangeSearchQueryProvider();
    await tester.pumpWidget(createWidgetUnderTest());
    final textField = find.byType(TextField);
    await tester.enterText(textField, 'new query');
    await tester.pumpAndSettle();
    expect(find.textContaining('Search for "new query"'), findsOneWidget);
  });

  testWidgets('Information about selected categories is displayed',
      (tester) async {
    arrangeSearchQueryProvider();
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('lorem +1'), findsOneWidget);
  });

  testWidgets('Information about selected radius of search is displayed',
      (tester) async {
    arrangeSearchQueryProvider();
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('< 100.0 km'), findsOneWidget);
  });
}
