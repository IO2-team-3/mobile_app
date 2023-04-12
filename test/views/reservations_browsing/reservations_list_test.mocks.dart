// Mocks generated by Mockito 5.3.2 from annotations
// in mobile_app/test/views/reservations_browsing/reservations_list_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:ui' as _i5;

import 'package:mobile_app/models/reservation.dart' as _i4;
import 'package:mobile_app/providers/reservations_provider.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

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

/// A class which mocks [ReservationsStorageProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockReservationsStorageProvider extends _i1.Mock
    implements _i2.ReservationsStorageProvider {
  MockReservationsStorageProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i3.Future<List<_i4.Reservation>> readReservations() => (super.noSuchMethod(
        Invocation.method(
          #readReservations,
          [],
        ),
        returnValue:
            _i3.Future<List<_i4.Reservation>>.value(<_i4.Reservation>[]),
      ) as _i3.Future<List<_i4.Reservation>>);
  @override
  _i3.Future<void> writeReservation(
    int? eventId,
    int? placeId,
    _i4.Reservation? reservation,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #writeReservation,
          [
            eventId,
            placeId,
            reservation,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  void addListener(_i5.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i5.VoidCallback? listener) => super.noSuchMethod(
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
