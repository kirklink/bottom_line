import 'package:test/test.dart';

import 'package:bottom_line/src/map_utilities.dart';

main() {
  group('grab', () {
    test('Picks a value from a Map.', () {
      var obj = {'test1': 1};
      var r = grab(obj, ['test1']);
      expect(r, equals(1));
    });
    test('Picks a nested value from a Map.', () {
      var obj = {
        'test1': {
          'test2': {'test3': 1}
        }
      };
      var r = grab(obj, ['test1', 'test2', 'test3']);
      expect(r, equals(1));
    });
  });

  group('pick', () {
    test('Gets the requested fields from a Map.', () {
      var obj = {'test1': 1, 'test2': 2, 'test3': 3.1, 'test4': 'four'};
      var r = pick(obj, ['test1', 'test3', 'test4']);
      var test = {'test1': 1, 'test3': 3.1, 'test4': 'four'};
      expect(r, equals(test));
    });
  });

  group('scan', () {
    test('Can find all the values in a Map.', () {
      var obj = {'test1': 1, 'test2': 2, 'test3': 3.1, 'test4': 'four'};
      ScanFunction f = (key, value, l) {
        l[key] = value;
        return l;
      };
      var s = scan(obj, f);
      expect(obj, equals(s));
    });
    test('Can flatten a Map.', () {
      var obj = {
        'test1': 1,
        'test2': 2,
        'test3': 3.1,
        'test4': {'test4a': 'four'}
      };
      ScanFunction f = (key, value, m) {
        m[key] = value;
        return m;
      };
      var s = scan(obj, f);
      expect(
          {'test1': 1, 'test2': 2, 'test3': 3.1, 'test4a': 'four'}, equals(s));
    });
    test('Can pull abitrary values from a Map.', () {
      var obj = {
        'test1': 1,
        'test2': 2,
        'test3': 3.1,
        'test4': {'test4a': 'four'}
      };
      ScanFunction f = (key, value, m) {
        if (key == 'test4a') m[key] = value;
        if (value == 2) m[key] = value;
        return m;
      };
      var s = scan(obj, f);
      expect({'test2': 2, 'test4a': 'four'}, equals(s));
    });
  });

  group('find', () {
    test('Locates the specified field.', () {
      var x = {'test1': 2, 'test2': 3, 'test3': 'test'};
      var r = find(x, 'test3');
      expect(r, equals('test'));
    });
    test('Locates the specified field if it is nested.', () {
      var x = {
        'test1': 2,
        'test2': 3,
        'test3': {
          'test3a': {'test3a1': 'test'},
          'test3b': 1,
        }
      };
      var r = find(x, 'test3a1');
      expect(r, equals('test'));
    });
    test('Returns null if the specified field cannot be found.', () {
      var x = {'test1': 2, 'test2': 3, 'test3': 'test'};
      var r = find(x, 'test4');
      expect(r, isNull);
    });
    test('Returns null if two fields with the same key are found.', () {
      var x = {
        'test1': 2,
        'test2': 'test',
        'test3': {
          'test3a': {
            'test3a1': {'test2': 'test'}
          },
          'test3b': 1,
        }
      };
      var r = find(x, 'test2');
      expect(r, isNull);
    });
  });
}
