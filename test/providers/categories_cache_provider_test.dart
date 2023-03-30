import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/providers/categories_cache_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:openapi/openapi.dart';

import 'categories_cache_provider_test.mocks.dart';

@GenerateMocks([APIProvider])
void main() {
  group('CategoriesCacheProvider', () {
    late CategoriesCacheProvider cacheProvider;
    late MockAPIProvider mockAPIProvider;

    setUp(() {
      mockAPIProvider = MockAPIProvider();
      cacheProvider = CategoriesCacheProvider(apiProvider: mockAPIProvider);
    });

    test('refreshAllCategories should update allCategories and lastFetchTime',
        () async {
      final categoriesList = BuiltList<Category>([]);
      when(mockAPIProvider.fetchCategoriesList()).thenAnswer((_) async =>
          Response(data: categoriesList, requestOptions: RequestOptions()));

      await cacheProvider.refreshAllCategories(false);

      expect(cacheProvider.allCategories!.data, categoriesList);
      expect(cacheProvider.lastFetchTime.isBefore(DateTime.now()), isTrue);
    });

    test(
        'getAllCategories should return allCategories when cache is valid and forceRefresh is false',
        () async {
      final categoriesList = BuiltList<Category>([]);
      cacheProvider.allCategories =
          Response(data: categoriesList, requestOptions: RequestOptions());
      cacheProvider.lastFetchTime = DateTime.now();

      final response = await cacheProvider.getAllCategories();

      expect(response.data, categoriesList);
    });

    test(
        'getAllCategories should call refreshAllCategories and return allCategories when cache is invalid and forceRefresh is false',
        () async {
      final categoriesList = BuiltList<Category>([]);
      when(mockAPIProvider.fetchCategoriesList()).thenAnswer((_) async =>
          Response(data: categoriesList, requestOptions: RequestOptions()));

      cacheProvider.allCategories = null;
      cacheProvider.lastFetchTime =
          DateTime.now().subtract(const Duration(minutes: 11));

      final response = await cacheProvider.getAllCategories();

      expect(cacheProvider.allCategories!.data, categoriesList);
      expect(response.data, categoriesList);
    });

    test(
        'getAllCategories should call refreshAllCategories and return allCategories when forceRefresh is true',
        () async {
      final categoriesList = BuiltList<Category>([]);
      when(mockAPIProvider.fetchCategoriesList()).thenAnswer((_) async =>
          Response(data: categoriesList, requestOptions: RequestOptions()));

      cacheProvider.allCategories = Response(
          data: BuiltList<Category>([]), requestOptions: RequestOptions());
      cacheProvider.lastFetchTime = DateTime.now();

      final response = await cacheProvider.getAllCategories(forceRefresh: true);

      expect(cacheProvider.allCategories!.data, categoriesList);
      expect(response.data, categoriesList);
    });
  });
}
