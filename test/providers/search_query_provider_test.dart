import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:openapi/openapi.dart';

void main() {
  group('SearchQueryProvider', () {
    test('addCategory() should add a category to the list', () {
      final searchQueryProvider = SearchQueryProvider();
      final category = (CategoryBuilder()
            ..id = 1
            ..name = 'Music')
          .build();
      searchQueryProvider.addCategory(category);
      expect(searchQueryProvider.categories, contains(category));
    });

    test('removeCategory() should remove a category from the list', () {
      final searchQueryProvider = SearchQueryProvider();
      final category = (CategoryBuilder()
            ..id = 1
            ..name = 'Music')
          .build();
      searchQueryProvider.addCategory(category);
      searchQueryProvider.removeCategory(category);
      expect(searchQueryProvider.categories, isNot(contains(category)));
    });

    test('removeAllCategories() should remove all categories from the list',
        () {
      final searchQueryProvider = SearchQueryProvider();
      final category1 = (CategoryBuilder()
            ..id = 1
            ..name = 'Music')
          .build();
      final category2 = (CategoryBuilder()
            ..id = 1
            ..name = 'Food')
          .build();
      searchQueryProvider.addCategory(category1);
      searchQueryProvider.addCategory(category2);
      searchQueryProvider.removeAllCategories();
      expect(searchQueryProvider.categories, isEmpty);
    });

    test('setEventName() should set the event name', () {
      final searchQueryProvider = SearchQueryProvider();
      searchQueryProvider.setEventName('Concert');
      expect(searchQueryProvider.eventName, 'Concert');
    });

    test('resetEventName() should reset the event name', () {
      final searchQueryProvider = SearchQueryProvider();
      searchQueryProvider.setEventName('Concert');
      searchQueryProvider.resetEventName();
      expect(searchQueryProvider.eventName, '');
    });

    test('setCurrentLocation() should set the current location', () {
      final searchQueryProvider = SearchQueryProvider();
      final location = Location(
          latitude: 37.7749, longitude: -122.4194, timestamp: DateTime(0));
      searchQueryProvider.setCurrentLocation(location);
      expect(searchQueryProvider.currentLocation, equals(location));
    });

    test('setDistance() should set the distance in km', () {
      final searchQueryProvider = SearchQueryProvider();
      searchQueryProvider.setDistance(10.0);
      expect(searchQueryProvider.distanceInKm, 10.0);
    });

    test('resetLocationQuery() should reset the location query', () {
      final searchQueryProvider = SearchQueryProvider();
      searchQueryProvider.setCurrentLocation(Location(
          latitude: 37.7749, longitude: -122.4194, timestamp: DateTime(0)));
      searchQueryProvider.setDistance(10.0);
      searchQueryProvider.resetLocationQuery();
      expect(searchQueryProvider.currentLocation, isNull);
      expect(searchQueryProvider.distanceInKm, isNull);
    });

    test('resetSearchQuery() should reset the entire search query', () {
      final searchQueryProvider = SearchQueryProvider();
      searchQueryProvider.addCategory((CategoryBuilder()
            ..id = 1
            ..name = 'Music')
          .build());
      searchQueryProvider.setEventName('Concert');
      searchQueryProvider.setCurrentLocation(Location(
          latitude: 37.7749, longitude: -122.4194, timestamp: DateTime(0)));
      searchQueryProvider.setDistance(10.0);
      searchQueryProvider.resetSearchQuery();
      expect(searchQueryProvider.categories, isEmpty);
      expect(searchQueryProvider.eventName, '');
      expect(searchQueryProvider.currentLocation, isNull);
      expect(searchQueryProvider.distanceInKm, isNull);
    });
  });
}
