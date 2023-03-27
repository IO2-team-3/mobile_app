import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:openapi/openapi.dart';

class CategoriesCacheProvider extends ChangeNotifier {
  APIProvider apiProvider;

  final Duration _cacheValidDuration = const Duration(minutes: 10);
  DateTime _lastFetchTime = DateTime.fromMicrosecondsSinceEpoch(0);
  Response<BuiltList<Category>>? _allCategories;

  CategoriesCacheProvider({required this.apiProvider});

  Future<void> refreshAllCategories(bool notifyListeners) async {
    _allCategories = await apiProvider.fetchCategoriesList();
    _lastFetchTime = DateTime.now();
    if (notifyListeners) {
      this.notifyListeners();
    }
  }

  Future<Response<BuiltList<Category>>> getAllCategories(
      {bool forceRefresh = false}) async {
    bool shouldRefreshFromApi = (_allCategories == null ||
        _lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidDuration)) ||
        forceRefresh);

    if (shouldRefreshFromApi) {
      await refreshAllCategories(false);
    }

    return _allCategories!;
  }
}
