import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:openapi/openapi.dart';

class CategoriesCacheProvider extends ChangeNotifier {
  APIProvider apiProvider;

  @visibleForTesting
  final Duration cacheValidDuration = const Duration(minutes: 10);

  @visibleForTesting
  DateTime lastFetchTime = DateTime.fromMicrosecondsSinceEpoch(0);

  @visibleForTesting
  Response<BuiltList<Category>>? allCategories;

  CategoriesCacheProvider({required this.apiProvider});

  Future<void> refreshAllCategories(bool notifyListeners) async {
    allCategories = await apiProvider.fetchCategoriesList();
    lastFetchTime = DateTime.now();
    if (notifyListeners) {
      this.notifyListeners();
    }
  }

  Future<Response<BuiltList<Category>>> getAllCategories(
      {bool forceRefresh = false}) async {
    bool shouldRefreshFromApi = (allCategories == null ||
        lastFetchTime.isBefore(DateTime.now().subtract(cacheValidDuration)) ||
        forceRefresh);

    if (shouldRefreshFromApi) {
      await refreshAllCategories(false);
    }

    return allCategories!;
  }
}
