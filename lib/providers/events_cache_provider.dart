import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:openapi/openapi.dart';

class EventsCacheProvider extends ChangeNotifier {
  APIProvider apiProvider;

  final Duration _cacheValidDuration = const Duration(minutes: 10);
  DateTime _lastFetchTime = DateTime.fromMicrosecondsSinceEpoch(0);
  Response<BuiltList<Event>>? _allEvents;

  EventsCacheProvider({required this.apiProvider});

  Future<void> refreshAllEvents(bool notifyListeners) async {
    _allEvents = await apiProvider.fetchEventsList();
    _lastFetchTime = DateTime.now();
    if (notifyListeners) {
      this.notifyListeners();
    }
  }

  Future<Response<BuiltList<Event>>> getAllEvents(
      {bool forceRefresh = false}) async {
    bool shouldRefreshFromApi = (_allEvents == null ||
        _lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidDuration)) ||
        forceRefresh);

    if (shouldRefreshFromApi) {
      await refreshAllEvents(false);
    }

    return _allEvents!;
  }
}
