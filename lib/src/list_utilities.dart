import 'package:bottom_line/src/map_utilities.dart';

List<Map<String, Object>> pluck(
    List<Map<String, Object>> list, List<String> fields,
    {bool partial: false}) {
  var result = List<Map<String, Object>>();
  for (var i in list) {
    var r = pick(i, fields, partial: partial);
    if (r != null) result.add(r);
  }
  return result;
}

List<Map<String, Object>> keepIf(
    List<Map<String, Object>> list, List<String> pathToField, Object value) {
  if (list == null || pathToField == null || value == null) return null;
  var r = List<Map<String, Object>>();
  for (var i in list) {
    var g = grab(i, pathToField);
    if (g == value) r.add(i);
  }
  return r;
}
