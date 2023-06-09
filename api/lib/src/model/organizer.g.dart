// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrganizerStatusEnum _$organizerStatusEnum_pending =
    const OrganizerStatusEnum._('pending');
const OrganizerStatusEnum _$organizerStatusEnum_confirmed =
    const OrganizerStatusEnum._('confirmed');

OrganizerStatusEnum _$organizerStatusEnumValueOf(String name) {
  switch (name) {
    case 'pending':
      return _$organizerStatusEnum_pending;
    case 'confirmed':
      return _$organizerStatusEnum_confirmed;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<OrganizerStatusEnum> _$organizerStatusEnumValues =
    new BuiltSet<OrganizerStatusEnum>(const <OrganizerStatusEnum>[
  _$organizerStatusEnum_pending,
  _$organizerStatusEnum_confirmed,
]);

Serializer<OrganizerStatusEnum> _$organizerStatusEnumSerializer =
    new _$OrganizerStatusEnumSerializer();

class _$OrganizerStatusEnumSerializer
    implements PrimitiveSerializer<OrganizerStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'confirmed': 'confirmed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'confirmed': 'confirmed',
  };

  @override
  final Iterable<Type> types = const <Type>[OrganizerStatusEnum];
  @override
  final String wireName = 'OrganizerStatusEnum';

  @override
  Object serialize(Serializers serializers, OrganizerStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrganizerStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrganizerStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Organizer extends Organizer {
  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  final OrganizerStatusEnum status;

  factory _$Organizer([void Function(OrganizerBuilder)? updates]) =>
      (new OrganizerBuilder()..update(updates))._build();

  _$Organizer._(
      {required this.id,
      required this.name,
      required this.email,
      required this.status})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Organizer', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'Organizer', 'name');
    BuiltValueNullFieldError.checkNotNull(email, r'Organizer', 'email');
    BuiltValueNullFieldError.checkNotNull(status, r'Organizer', 'status');
  }

  @override
  Organizer rebuild(void Function(OrganizerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrganizerBuilder toBuilder() => new OrganizerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Organizer &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Organizer')
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('status', status))
        .toString();
  }
}

class OrganizerBuilder implements Builder<Organizer, OrganizerBuilder> {
  _$Organizer? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  OrganizerStatusEnum? _status;
  OrganizerStatusEnum? get status => _$this._status;
  set status(OrganizerStatusEnum? status) => _$this._status = status;

  OrganizerBuilder() {
    Organizer._defaults(this);
  }

  OrganizerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Organizer other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Organizer;
  }

  @override
  void update(void Function(OrganizerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Organizer build() => _build();

  _$Organizer _build() {
    final _$result = _$v ??
        new _$Organizer._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Organizer', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'Organizer', 'name'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'Organizer', 'email'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'Organizer', 'status'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
