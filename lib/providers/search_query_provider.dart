import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:openapi/openapi.dart';

class SearchQueryProvider extends ChangeNotifier {
  final List<Category> _categories = [];
  String _eventName = "";
  Location? _location;
  double? _distanceInKm;

  UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);

  String get eventName => _eventName;

  Location? get currentLocation => _location;
  double? get distanceInKm => _distanceInKm;

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }

  void removeCategory(Category category) {
    _categories.remove(category);
    notifyListeners();
  }

  void removeAllCategories() {
    _categories.clear();
    notifyListeners();
  }

  void setEventName(String eventName) {
    _eventName = eventName;
    notifyListeners();
  }

  void resetEventName() {
    _eventName = eventName;
    notifyListeners();
  }

  void setCurrentLocation(Location location) {
    _location = location;
    notifyListeners();
  }

  void setDistance(double dist) {
    _distanceInKm = dist;
    notifyListeners();
  }

  void resetLocationQuery() {
    _distanceInKm = null;
    _location = null;
    notifyListeners();
  }

  void resetSearchQuery() {
    _eventName = "";
    _categories.clear();
    _distanceInKm = null;
    _location = null;
    notifyListeners();
  }
}
