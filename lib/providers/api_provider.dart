import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

class APIProvider extends ChangeNotifier {
  Openapi api;
  APIProvider({required this.api});

  Future<Response<BuiltList<Event>>> fetchEventsList() async {
    return api.getEventApi().getEvents();
  }
}
