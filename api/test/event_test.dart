import 'package:test/test.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';

// tests for Event
void main() {
  final instance = EventBuilder();
  final categoryBuilder = CategoryBuilder();

  final _id = 1;
  final _freePlace = 10;
  final _title = 'test-title';
  final _startTime = 1000;
  final _endTime = 9000;
  final _latitude = 12.34;
  final _longitude = 56.789;
  final _name = 'test-name';
  final _placeSchema = 'abcd1234';
  final _status = EventStatus.cancelled;
  final _categories = ListBuilder<Category>([
    (categoryBuilder
          ..id = 1
          ..name = 'test-category1')
        .build(),
    (categoryBuilder
          ..id = 2
          ..name = 'test-category2')
        .build()
  ]);

  instance
    ..id = _id
    ..freePlace = _freePlace
    ..title = _title
    ..startTime = _startTime
    ..endTime = _endTime
    ..latitude = _latitude
    ..longitude = _longitude
    ..name = _name
    ..placeSchema = _placeSchema
    ..status = _status
    ..categories = _categories

  final subject = instance.build();

  group(Event, () {
    // int id
    test('to test the property `id`', () async {
      expect(subject.id, _id);
    });

    // int freePlace
    test('to test the property `freePlace`', () async {
      expect(subject.freePlace, _freePlace);
    });

    // String title
    test('to test the property `title`', () async {
      expect(subject.title, _title);
    });

    // int startTime
    test('to test the property `startTime`', () async {
      expect(subject.startTime, _startTime);
    });

    // int endTime
    test('to test the property `endTime`', () async {
      expect(subject.endTime, _endTime);
    });

    // String latitude
    test('to test the property `latitude`', () async {
      expect(subject.latitude, _latitude);
    });

    // String longitude
    test('to test the property `longitude`', () async {
      expect(subject.longitude, _longitude);
    });

    // String name
    test('to test the property `name`', () async {
      expect(subject.name, _name);
    });

    // String placeSchema
    test('to test the property `placeSchema`', () async {
      expect(subject.placeSchema, _placeSchema);
    });

    // EventStatus status
    test('to test the property `status`', () async {
      expect(subject.status, _status);
    });

    // BuiltList<Category> categories
    test('to test the property `categories`', () async {
      expect(subject.categories, _categories);
    });
  });
}
