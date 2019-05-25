bool isType<T>(Object input) {
  return (input is T);
}

String typeof(Object input) {
  if (input is String) return 'String';
  if (input is int) return 'int';
  if (input is double) return 'double';
  if (input is List) return 'List';
  if (input is Map) return 'Map';
  return null;
}

T toType<T>(Object input) => (input as T);

class Caster {
  Object _input;

  Caster(this._input);

  T toType<T>() {
    if (_input is! T)
      return null;
    else
      return (_input as T);
  }

  bool isType<T>() {
    return (_input is T);
  }

  String get type => typeof(_input);

  String toString() {
    if (_input is String) return (_input as String);
    return null;
  }

  int toInt() {
    if (_input is int) return (_input as int);
    return null;
  }

  double toDouble() {
    if (_input is double) return (_input as double);
    return null;
  }

  num toNum() {
    if (_input is num) return (_input as num);
    return null;
  }

  List toList() {
    if (_input is List) return (_input as List);
    return null;
  }

  Map toMap() {
    if (_input is Map) return (_input as Map);
    return null;
  }
}
