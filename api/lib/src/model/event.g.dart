// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Event extends Event {
  @override
  final int id;
  @override
  final String title;
  @override
  final int startTime;
  @override
  final int endTime;
  @override
  final String latitude;
  @override
  final String longitude;
  @override
  final String name;
  @override
  final EventStatus status;
  @override
  final BuiltList<Category> categories;
  @override
  final int freePlace;
  @override
  final int maxPlace;

  factory _$Event([void Function(EventBuilder)? updates]) =>
      (new EventBuilder()..update(updates))._build();

  _$Event._(
      {required this.id,
      required this.title,
      required this.startTime,
      required this.endTime,
      required this.latitude,
      required this.longitude,
      required this.name,
      required this.status,
      required this.categories,
      required this.freePlace,
      required this.maxPlace})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Event', 'id');
    BuiltValueNullFieldError.checkNotNull(title, r'Event', 'title');
    BuiltValueNullFieldError.checkNotNull(startTime, r'Event', 'startTime');
    BuiltValueNullFieldError.checkNotNull(endTime, r'Event', 'endTime');
    BuiltValueNullFieldError.checkNotNull(latitude, r'Event', 'latitude');
    BuiltValueNullFieldError.checkNotNull(longitude, r'Event', 'longitude');
    BuiltValueNullFieldError.checkNotNull(name, r'Event', 'name');
    BuiltValueNullFieldError.checkNotNull(status, r'Event', 'status');
    BuiltValueNullFieldError.checkNotNull(categories, r'Event', 'categories');
    BuiltValueNullFieldError.checkNotNull(freePlace, r'Event', 'freePlace');
    BuiltValueNullFieldError.checkNotNull(maxPlace, r'Event', 'maxPlace');
  }

  @override
  Event rebuild(void Function(EventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EventBuilder toBuilder() => new EventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Event &&
        id == other.id &&
        title == other.title &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        name == other.name &&
        status == other.status &&
        categories == other.categories &&
        freePlace == other.freePlace &&
        maxPlace == other.maxPlace;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jc(_$hash, freePlace.hashCode);
    _$hash = $jc(_$hash, maxPlace.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Event')
          ..add('id', id)
          ..add('title', title)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('name', name)
          ..add('status', status)
          ..add('categories', categories)
          ..add('freePlace', freePlace)
          ..add('maxPlace', maxPlace))
        .toString();
  }
}

class EventBuilder implements Builder<Event, EventBuilder> {
  _$Event? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _startTime;
  int? get startTime => _$this._startTime;
  set startTime(int? startTime) => _$this._startTime = startTime;

  int? _endTime;
  int? get endTime => _$this._endTime;
  set endTime(int? endTime) => _$this._endTime = endTime;

  String? _latitude;
  String? get latitude => _$this._latitude;
  set latitude(String? latitude) => _$this._latitude = latitude;

  String? _longitude;
  String? get longitude => _$this._longitude;
  set longitude(String? longitude) => _$this._longitude = longitude;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  EventStatus? _status;
  EventStatus? get status => _$this._status;
  set status(EventStatus? status) => _$this._status = status;

  ListBuilder<Category>? _categories;
  ListBuilder<Category> get categories =>
      _$this._categories ??= new ListBuilder<Category>();
  set categories(ListBuilder<Category>? categories) =>
      _$this._categories = categories;

  int? _freePlace;
  int? get freePlace => _$this._freePlace;
  set freePlace(int? freePlace) => _$this._freePlace = freePlace;

  int? _maxPlace;
  int? get maxPlace => _$this._maxPlace;
  set maxPlace(int? maxPlace) => _$this._maxPlace = maxPlace;

  EventBuilder() {
    Event._defaults(this);
  }

  EventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _name = $v.name;
      _status = $v.status;
      _categories = $v.categories.toBuilder();
      _freePlace = $v.freePlace;
      _maxPlace = $v.maxPlace;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Event other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Event;
  }

  @override
  void update(void Function(EventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Event build() => _build();

  _$Event _build() {
    _$Event _$result;
    try {
      _$result = _$v ??
          new _$Event._(
              id: BuiltValueNullFieldError.checkNotNull(id, r'Event', 'id'),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'Event', 'title'),
              startTime: BuiltValueNullFieldError.checkNotNull(
                  startTime, r'Event', 'startTime'),
              endTime: BuiltValueNullFieldError.checkNotNull(
                  endTime, r'Event', 'endTime'),
              latitude: BuiltValueNullFieldError.checkNotNull(
                  latitude, r'Event', 'latitude'),
              longitude: BuiltValueNullFieldError.checkNotNull(
                  longitude, r'Event', 'longitude'),
              name:
                  BuiltValueNullFieldError.checkNotNull(name, r'Event', 'name'),
              status: BuiltValueNullFieldError.checkNotNull(
                  status, r'Event', 'status'),
              categories: categories.build(),
              freePlace: BuiltValueNullFieldError.checkNotNull(
                  freePlace, r'Event', 'freePlace'),
              maxPlace: BuiltValueNullFieldError.checkNotNull(
                  maxPlace, r'Event', 'maxPlace'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'categories';
        categories.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Event', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
