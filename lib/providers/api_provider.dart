import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart' as provider;
import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

class APIProvider extends provider.ChangeNotifier {
  Openapi api;
  APIProvider({required this.api});

  Future<Response<BuiltList<Event>>> fetchEventsList() async {
    return api.getEventApi().getEvents();
  }

  Future<Response<Event>> fetchEventById({required int id}) async {
    return api.getEventApi().getEventById(id: id);
  }

  Future<Response<BuiltList<Event>>> fetchMyEvents() async {
    return api.getEventApi().getMyEvents();
  }

  Future<Response<BuiltList<Category>>> fetchCategoriesList() async {
    return api.getCategoriesApi().getCategories();
  }

  Future<Response<BuiltList<Event>>> fetchEventByCategoryId({
    required int categoryId,
  }) async {
    return api.getEventApi().getByCategory(categoryId: categoryId);
  }
}
