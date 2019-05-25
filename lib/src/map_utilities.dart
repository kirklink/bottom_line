Object grab(Map<String, Object> input, List<String> pathToField) {
  if (input == null || pathToField == null || pathToField.isEmpty) return null;
  for (var i = 0; i < pathToField.length; i++) {
    var field = pathToField[i];
    if (!input.containsKey(field)) return null;
    if (i == pathToField.length - 1) {
      return input[field];
    }
    if (input[field] is! Map<String, Object>) return null;
    input = input[field];
  }
  return null;
}

Map<String, Object> pick(Map<String, Object> input, List<String> fields,
    {bool partial: false}) {
  if (input == null || fields == null || fields.isEmpty) return null;
  var r = Map<String, Object>();
  for (var f in fields) {
    if (input.containsKey(f)) r[f] = input[f];
  }
  if (partial) {
    return r;
  } else if (fields.length == r.length) {
    return r;
  } else {
    return null;
  }
}

List<Object> _seek(Map<String, Object> input, String field) {
  var r = List<Object>();
  for (var k in input.keys) {
    if (k == field) r.add(input[k]);
    if (input[k] is Map) {
      var n = _seek(input[k], field);
      r.addAll(n);
      return r;
    }
  }
  return r;
}

T find<T>(Map<String, Object> input, String field) {
  if (input == null || field == null || field == '') return null;
  var r = List<Object>();
  r = _seek(input, field);
  if (r.length == 0 || r.length > 1 || r[0] is! T) return null;
  return (r[0] as T);
}

typedef Map<String, Object> ScanFunction(
    String key, Object value, Map<String, Object> collector);

Map<String, Object> _scan(
    Map<String, Object> input, ScanFunction f, Map<String, Object> collector) {
  for (var k in input.keys) {
    if (input[k] is Map<String, Object>) {
      collector = _scan(input[k], f, collector);
    } else {
      collector = f(k, input[k], collector);
    }
  }
  return collector;
}

Map<String, Object> scan(Map<String, Object> input, ScanFunction f) {
  return _scan(input, f, Map<String, Object>());
}
