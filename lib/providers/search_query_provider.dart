import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:openapi/openapi.dart';

class SearchQueryProvider extends ChangeNotifier {
  final List<Category> _categories = [];
  String _eventName = "";
  Location? _location;
  double? _distance;

  UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);

  String get eventName => _eventName;

  Location? get currentLocation => _location;
  double? get distance => _distance;

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
    _distance = dist;
    notifyListeners();
  }

  void resetLocationQuery() {
    _distance = null;
    _location = null;
    notifyListeners();
  }

  void resetSearchQuery() {
    _eventName = "";
    _categories.clear();
    _distance = null;
    _location = null;
    notifyListeners();
  }
}
