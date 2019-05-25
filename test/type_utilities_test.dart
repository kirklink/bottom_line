import 'package:test/test.dart';

import 'package:bottom_line/src/type_utilities.dart' as tu;

main() async {
  group('Functions', () {
    test('isType is true when the same type is provided.', () {
      expect(tu.isType<String>('string'), isTrue);
    });
    test('isType is false when a different type is provided.', () {
      expect(tu.isType<String>(1), isFalse);
    });
  });

  group('typeof', () {
    test('typeof is "String" for strings.', () {
      expect(tu.typeof('string'), equals('String'));
    });
    test('typeof is "int" for integers.', () {
      expect(tu.typeof(1), equals('int'));
    });
    test('typeof is "double" for floats.', () {
      expect(tu.typeof(1.1), equals('double'));
    });
    test('typeof is "Map" for Maps.', () {
      expect(tu.typeof({}), equals('Map'));
    });
    test('typeof is "List" for lists.', () {
      expect(tu.typeof([]), equals('List'));
    });
  });

  group('Caster', () {
    test('Caster returns type String for strings', () {
      var c = tu.Caster('test');
      expect(c.type, equals('String'));
    });
    test('Caster returns null if it can\'t set the type', () {
      var c = tu.Caster(1);
      expect(c.toString(), isNull);
    });
    test('Caster.toString returns its value as a string.', () {
      var c = tu.Caster('test');
      expect(c.toString() is String, isTrue);
    });
    test('Caster.toType> returns its value as the type.', () {
      var c = tu.Caster('test');
      expect(c.toType<String>() is String, isTrue);
    });
    test('Caster.toType return null if its value isn\'t the provided type.',
        () {
      var c = tu.Caster('test');
      expect(c.toType<int>(), isNull);
    });
  });
}
