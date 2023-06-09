//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/event_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/category.dart';
import 'package:openapi/src/model/place.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'event_with_places.g.dart';

/// EventWithPlaces
///
/// Properties:
/// * [id] 
/// * [title] 
/// * [startTime] 
/// * [endTime] 
/// * [latitude] 
/// * [longitude] 
/// * [name] 
/// * [status] 
/// * [categories] 
/// * [freePlace] 
/// * [maxPlace] 
/// * [places] 
/// * [placeSchema] 
@BuiltValue()
abstract class EventWithPlaces implements Built<EventWithPlaces, EventWithPlacesBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'startTime')
  int get startTime;

  @BuiltValueField(wireName: r'endTime')
  int get endTime;

  @BuiltValueField(wireName: r'latitude')
  String get latitude;

  @BuiltValueField(wireName: r'longitude')
  String get longitude;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'status')
  EventStatus get status;
  // enum statusEnum {  inFuture,  pending,  done,  cancelled,  };

  @BuiltValueField(wireName: r'categories')
  BuiltList<Category> get categories;

  @BuiltValueField(wireName: r'freePlace')
  int get freePlace;

  @BuiltValueField(wireName: r'maxPlace')
  int get maxPlace;

  @BuiltValueField(wireName: r'places')
  BuiltList<Place> get places;

  @BuiltValueField(wireName: r'placeSchema')
  String? get placeSchema;

  EventWithPlaces._();

  factory EventWithPlaces([void updates(EventWithPlacesBuilder b)]) = _$EventWithPlaces;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EventWithPlacesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EventWithPlaces> get serializer => _$EventWithPlacesSerializer();
}

class _$EventWithPlacesSerializer implements PrimitiveSerializer<EventWithPlaces> {
  @override
  final Iterable<Type> types = const [EventWithPlaces, _$EventWithPlaces];

  @override
  final String wireName = r'EventWithPlaces';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EventWithPlaces object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'startTime';
    yield serializers.serialize(
      object.startTime,
      specifiedType: const FullType(int),
    );
    yield r'endTime';
    yield serializers.serialize(
      object.endTime,
      specifiedType: const FullType(int),
    );
    yield r'latitude';
    yield serializers.serialize(
      object.latitude,
      specifiedType: const FullType(String),
    );
    yield r'longitude';
    yield serializers.serialize(
      object.longitude,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(EventStatus),
    );
    yield r'categories';
    yield serializers.serialize(
      object.categories,
      specifiedType: const FullType(BuiltList, [FullType(Category)]),
    );
    yield r'freePlace';
    yield serializers.serialize(
      object.freePlace,
      specifiedType: const FullType(int),
    );
    yield r'maxPlace';
    yield serializers.serialize(
      object.maxPlace,
      specifiedType: const FullType(int),
    );
    yield r'places';
    yield serializers.serialize(
      object.places,
      specifiedType: const FullType(BuiltList, [FullType(Place)]),
    );
    if (object.placeSchema != null) {
      yield r'placeSchema';
      yield serializers.serialize(
        object.placeSchema,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EventWithPlaces object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EventWithPlacesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'startTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.startTime = valueDes;
          break;
        case r'endTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.endTime = valueDes;
          break;
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.latitude = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.longitude = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EventStatus),
          ) as EventStatus;
          result.status = valueDes;
          break;
        case r'categories':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Category)]),
          ) as BuiltList<Category>;
          result.categories.replace(valueDes);
          break;
        case r'freePlace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.freePlace = valueDes;
          break;
        case r'maxPlace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxPlace = valueDes;
          break;
        case r'places':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Place)]),
          ) as BuiltList<Place>;
          result.places.replace(valueDes);
          break;
        case r'placeSchema':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.placeSchema = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EventWithPlaces deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EventWithPlacesBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

