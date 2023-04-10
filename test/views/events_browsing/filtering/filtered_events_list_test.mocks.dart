// Mocks generated by Mockito 5.3.2 from annotations
// in mobile_app/test/views/events_browsing/filtering/filtered_events_list_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:collection' as _i5;
import 'dart:ui' as _i9;

import 'package:built_collection/built_collection.dart' as _i7;
import 'package:dio/dio.dart' as _i3;
import 'package:geocoding/geocoding.dart' as _i11;
import 'package:mobile_app/providers/api_provider.dart' as _i2;
import 'package:mobile_app/providers/events_cache_provider.dart' as _i6;
import 'package:mobile_app/providers/search_query_provider.dart' as _i10;
import 'package:mockito/mockito.dart' as _i1;
import 'package:openapi/openapi.dart' as _i4;

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

class _FakeAPIProvider_0 extends _i1.SmartFake implements _i2.APIProvider {
  _FakeAPIProvider_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDuration_1 extends _i1.SmartFake implements Duration {
  _FakeDuration_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDateTime_2 extends _i1.SmartFake implements DateTime {
  _FakeDateTime_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_3<T> extends _i1.SmartFake implements _i3.Response<T> {
  _FakeResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOpenapi_4 extends _i1.SmartFake implements _i4.Openapi {
  _FakeOpenapi_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUnmodifiableListView_5<E> extends _i1.SmartFake
    implements _i5.UnmodifiableListView<E> {
  _FakeUnmodifiableListView_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [EventsCacheProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockEventsCacheProvider extends _i1.Mock
    implements _i6.EventsCacheProvider {
  MockEventsCacheProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.APIProvider get apiProvider => (super.noSuchMethod(
        Invocation.getter(#apiProvider),
        returnValue: _FakeAPIProvider_0(
          this,
          Invocation.getter(#apiProvider),
        ),
      ) as _i2.APIProvider);
  @override
  set apiProvider(_i2.APIProvider? _apiProvider) => super.noSuchMethod(
        Invocation.setter(
          #apiProvider,
          _apiProvider,
        ),
        returnValueForMissingStub: null,
      );
  @override
  Duration get cacheValidDuration => (super.noSuchMethod(
        Invocation.getter(#cacheValidDuration),
        returnValue: _FakeDuration_1(
          this,
          Invocation.getter(#cacheValidDuration),
        ),
      ) as Duration);
  @override
  DateTime get lastFetchTime => (super.noSuchMethod(
        Invocation.getter(#lastFetchTime),
        returnValue: _FakeDateTime_2(
          this,
          Invocation.getter(#lastFetchTime),
        ),
      ) as DateTime);
  @override
  set lastFetchTime(DateTime? _lastFetchTime) => super.noSuchMethod(
        Invocation.setter(
          #lastFetchTime,
          _lastFetchTime,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set allEvents(_i3.Response<_i7.BuiltList<_i4.Event>>? _allEvents) =>
      super.noSuchMethod(
        Invocation.setter(
          #allEvents,
          _allEvents,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i8.Future<void> refreshAllEvents(bool? notifyListeners) =>
      (super.noSuchMethod(
        Invocation.method(
          #refreshAllEvents,
          [notifyListeners],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>> getAllEvents(
          {bool? forceRefresh = false}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllEvents,
          [],
          {#forceRefresh: forceRefresh},
        ),
        returnValue: _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>>.value(
            _FakeResponse_3<_i7.BuiltList<_i4.Event>>(
          this,
          Invocation.method(
            #getAllEvents,
            [],
            {#forceRefresh: forceRefresh},
          ),
        )),
      ) as _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>>);
  @override
  void addListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i9.VoidCallback? listener) => super.noSuchMethod(
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

/// A class which mocks [APIProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockAPIProvider extends _i1.Mock implements _i2.APIProvider {
  MockAPIProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Openapi get api => (super.noSuchMethod(
        Invocation.getter(#api),
        returnValue: _FakeOpenapi_4(
          this,
          Invocation.getter(#api),
        ),
      ) as _i4.Openapi);
  @override
  set api(_i4.Openapi? _api) => super.noSuchMethod(
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
  _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>> fetchEventsList() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchEventsList,
          [],
        ),
        returnValue: _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>>.value(
            _FakeResponse_3<_i7.BuiltList<_i4.Event>>(
          this,
          Invocation.method(
            #fetchEventsList,
            [],
          ),
        )),
      ) as _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>>);
  @override
  _i8.Future<_i3.Response<_i4.EventWithPlaces>> fetchEventById(
          {required int? id}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchEventById,
          [],
          {#id: id},
        ),
        returnValue: _i8.Future<_i3.Response<_i4.EventWithPlaces>>.value(
            _FakeResponse_3<_i4.EventWithPlaces>(
          this,
          Invocation.method(
            #fetchEventById,
            [],
            {#id: id},
          ),
        )),
      ) as _i8.Future<_i3.Response<_i4.EventWithPlaces>>);
  @override
  _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>> fetchMyEvents() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchMyEvents,
          [],
        ),
        returnValue: _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>>.value(
            _FakeResponse_3<_i7.BuiltList<_i4.Event>>(
          this,
          Invocation.method(
            #fetchMyEvents,
            [],
          ),
        )),
      ) as _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>>);
  @override
  _i8.Future<_i3.Response<_i7.BuiltList<_i4.Category>>> fetchCategoriesList() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchCategoriesList,
          [],
        ),
        returnValue:
            _i8.Future<_i3.Response<_i7.BuiltList<_i4.Category>>>.value(
                _FakeResponse_3<_i7.BuiltList<_i4.Category>>(
          this,
          Invocation.method(
            #fetchCategoriesList,
            [],
          ),
        )),
      ) as _i8.Future<_i3.Response<_i7.BuiltList<_i4.Category>>>);
  @override
  _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>> fetchEventByCategoryId(
          {required int? categoryId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchEventByCategoryId,
          [],
          {#categoryId: categoryId},
        ),
        returnValue: _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>>.value(
            _FakeResponse_3<_i7.BuiltList<_i4.Event>>(
          this,
          Invocation.method(
            #fetchEventByCategoryId,
            [],
            {#categoryId: categoryId},
          ),
        )),
      ) as _i8.Future<_i3.Response<_i7.BuiltList<_i4.Event>>>);
  @override
  _i8.Future<_i3.Response<_i4.ReservationDTO>> makeReservation({
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
        returnValue: _i8.Future<_i3.Response<_i4.ReservationDTO>>.value(
            _FakeResponse_3<_i4.ReservationDTO>(
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
      ) as _i8.Future<_i3.Response<_i4.ReservationDTO>>);
  @override
  void addListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i9.VoidCallback? listener) => super.noSuchMethod(
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

/// A class which mocks [SearchQueryProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchQueryProvider extends _i1.Mock
    implements _i10.SearchQueryProvider {
  MockSearchQueryProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.UnmodifiableListView<_i4.Category> get categories => (super.noSuchMethod(
        Invocation.getter(#categories),
        returnValue: _FakeUnmodifiableListView_5<_i4.Category>(
          this,
          Invocation.getter(#categories),
        ),
      ) as _i5.UnmodifiableListView<_i4.Category>);
  @override
  String get eventName => (super.noSuchMethod(
        Invocation.getter(#eventName),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  void addCategory(_i4.Category? category) => super.noSuchMethod(
        Invocation.method(
          #addCategory,
          [category],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeCategory(_i4.Category? category) => super.noSuchMethod(
        Invocation.method(
          #removeCategory,
          [category],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeAllCategories() => super.noSuchMethod(
        Invocation.method(
          #removeAllCategories,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setEventName(String? eventName) => super.noSuchMethod(
        Invocation.method(
          #setEventName,
          [eventName],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void resetEventName() => super.noSuchMethod(
        Invocation.method(
          #resetEventName,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setCurrentLocation(_i11.Location? location) => super.noSuchMethod(
        Invocation.method(
          #setCurrentLocation,
          [location],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setDistance(double? dist) => super.noSuchMethod(
        Invocation.method(
          #setDistance,
          [dist],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void resetLocationQuery() => super.noSuchMethod(
        Invocation.method(
          #resetLocationQuery,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void resetSearchQuery() => super.noSuchMethod(
        Invocation.method(
          #resetSearchQuery,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i9.VoidCallback? listener) => super.noSuchMethod(
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
