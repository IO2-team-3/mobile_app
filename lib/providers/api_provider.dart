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

  Future<Response<EventWithPlaces>> fetchEventById({required int id}) async {
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

  Future<Response<ReservationDTO>> makeReservation({
    required int eventId,
    int? placeId,
  }) async {
    return api
        .getReservationApi()
        .makeReservation(eventId: eventId, placeID: placeId);
  }

  Future<Response<void>> deleteReservation({
    required String reservationToken,
  }) async {
    return api
        .getReservationApi()
        .deleteReservation(reservationToken: reservationToken);
  }

  Future<Response<BuiltList<String>>> listPhotosForEvent(
      {required int eventId}) async {
    //return 'https://io2-central-photos.s3.amazonaws.com/' + api.getEventApi().getPhoto(id: eventId); // TODO
    return Response(
      requestOptions: RequestOptions(),
      data: BuiltList.from(
        List.generate(
          3,
          (_) =>
              'https://io2-central-photos.s3.amazonaws.com/event/464/00201.jpg',
        ),
      ),
    );
  }
}
