// Mocks generated by Mockito 5.3.2 from annotations
// in mobile_app/test/providers/categories_cache_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i7;

import 'package:built_collection/built_collection.dart' as _i6;
import 'package:dio/dio.dart' as _i3;
import 'package:mobile_app/providers/api_provider.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:openapi/openapi.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeOpenapi_0 extends _i1.SmartFake implements _i2.Openapi {
  _FakeOpenapi_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_1<T> extends _i1.SmartFake implements _i3.Response<T> {
  _FakeResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [APIProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockAPIProvider extends _i1.Mock implements _i4.APIProvider {
  MockAPIProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Openapi get api => (super.noSuchMethod(
        Invocation.getter(#api),
        returnValue: _FakeOpenapi_0(
          this,
          Invocation.getter(#api),
        ),
      ) as _i2.Openapi);
  @override
  set api(_i2.Openapi? _api) => super.noSuchMethod(
        Invocation.setter(
          #api,
          _api,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i5.Future<_i3.Response<_i6.BuiltList<_i2.Event>>> fetchEventsList() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchEventsList,
          [],
        ),
        returnValue: _i5.Future<_i3.Response<_i6.BuiltList<_i2.Event>>>.value(
            _FakeResponse_1<_i6.BuiltList<_i2.Event>>(
          this,
          Invocation.method(
            #fetchEventsList,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Response<_i6.BuiltList<_i2.Event>>>);
  @override
  _i5.Future<_i3.Response<_i2.EventWithPlaces>> fetchEventById(
          {required int? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchEventById,
          [],
          {#id: id},
        ),
        returnValue: _i5.Future<_i3.Response<_i2.EventWithPlaces>>.value(
            _FakeResponse_1<_i2.EventWithPlaces>(
          this,
          Invocation.method(
            #fetchEventById,
            [],
            {#id: id},
          ),
        )),
      ) as _i5.Future<_i3.Response<_i2.EventWithPlaces>>);
  @override
  _i5.Future<_i3.Response<_i6.BuiltList<_i2.Event>>> fetchMyEvents() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchMyEvents,
          [],
        ),
        returnValue: _i5.Future<_i3.Response<_i6.BuiltList<_i2.Event>>>.value(
            _FakeResponse_1<_i6.BuiltList<_i2.Event>>(
          this,
          Invocation.method(
            #fetchMyEvents,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Response<_i6.BuiltList<_i2.Event>>>);
  @override
  _i5.Future<_i3.Response<_i6.BuiltList<_i2.Category>>> fetchCategoriesList() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchCategoriesList,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Response<_i6.BuiltList<_i2.Category>>>.value(
                _FakeResponse_1<_i6.BuiltList<_i2.Category>>(
          this,
          Invocation.method(
            #fetchCategoriesList,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Response<_i6.BuiltList<_i2.Category>>>);
  @override
  _i5.Future<_i3.Response<_i6.BuiltList<_i2.Event>>> fetchEventByCategoryId(
          {required int? categoryId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchEventByCategoryId,
          [],
          {#categoryId: categoryId},
        ),
        returnValue: _i5.Future<_i3.Response<_i6.BuiltList<_i2.Event>>>.value(
            _FakeResponse_1<_i6.BuiltList<_i2.Event>>(
          this,
          Invocation.method(
            #fetchEventByCategoryId,
            [],
            {#categoryId: categoryId},
          ),
        )),
      ) as _i5.Future<_i3.Response<_i6.BuiltList<_i2.Event>>>);
  @override
  _i5.Future<_i3.Response<_i2.ReservationDTO>> makeReservation({
    required int? eventId,
    int? placeId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #makeReservation,
          [],
          {
            #eventId: eventId,
            #placeId: placeId,
          },
        ),
        returnValue: _i5.Future<_i3.Response<_i2.ReservationDTO>>.value(
            _FakeResponse_1<_i2.ReservationDTO>(
          this,
          Invocation.method(
            #makeReservation,
            [],
            {
              #eventId: eventId,
              #placeId: placeId,
            },
          ),
        )),
      ) as _i5.Future<_i3.Response<_i2.ReservationDTO>>);
  @override
  _i5.Future<_i3.Response<void>> deleteReservation(
          {required String? reservationToken}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteReservation,
          [],
          {#reservationToken: reservationToken},
        ),
        returnValue: _i5.Future<_i3.Response<void>>.value(_FakeResponse_1<void>(
          this,
          Invocation.method(
            #deleteReservation,
            [],
            {#reservationToken: reservationToken},
          ),
        )),
      ) as _i5.Future<_i3.Response<void>>);
  @override
  void addListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
