import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

// tests for Category
void main() {
  final instance = CategoryBuilder();
  final _id = 1;
  final _name = 'test-category';

  instance
    ..id = _id
    ..name = _name
  final subject = instance.build();

  group(Category, () {
    // int id
    test('to test the property `id`', () async {
      expect(subject.id, _id);
    });

    // String name
    test('to test the property `name`', () async {
      expect(subject.name, _name);
    });
  });
}
