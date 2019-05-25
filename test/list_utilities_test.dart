import 'package:test/test.dart';

import 'package:bottom_line/src/list_utilities.dart';

main() {
  group('pluck', () {
    test('pluck gets the objects with the requested fields from a list.', () {
      var obj = {'test1': 1, 'test2': 2, 'test3': 3.1, 'test4': 'four'};
      var l = [obj, obj, obj];
      var test = {'test1': 1, 'test3': 3.1, 'test4': 'four'};
      var r = pluck(l, ['test1', 'test3', 'test4']);
      expect([test, test, test], equals(r));
    });
  });

  group('keep', () {
    test('keep retains the objects that contain the provided value.', () {
      var obj = {'test1': 1, 'test2': 2, 'test3': 3.1, 'test4': 'four'};
      var l = [obj, obj, obj];
      var r = keepIf(l, ['test2'], 2);
      expect(r.length, equals(3));
    });
    test('keep retains the objects that contain the provided value.', () {
      var obj = {'test1': 1, 'test2': 2, 'test3': 3.1, 'test4': 'four'};
      var l = [obj, obj, obj];
      var r = keepIf(l, ['test2'], 2);
      expect(l, equals(r));
    });
    test('keep retains the objects that contain the provided value.', () {
      var obj1 = {'test1': 1, 'test2': 2};
      var obj2 = {'test1': 1, 'test2': 'test'};
      var obj3 = {
        'test1': 1,
        'test2': 'test',
        'test3': {'test3a': 2}
      };
      var obj4 = {
        'test1': 1,
        'test2': 'test',
        'test3': {'test3a': 1}
      };
      var l = [obj1, obj2, obj3, obj4];
      var r = keepIf(l, ['test2'], 'test');
      var r2 = keepIf(r, ['test3', 'test3a'], 2);
      // expect(r, equals([obj2, obj3, obj4]));
      expect(r2, equals([obj3]));
    });
  });
}
