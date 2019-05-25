import 'package:bottom_line/src/type_utilities.dart';
import 'package:bottom_line/src/map_utilities.dart' as map_utils;
import 'package:bottom_line/src/list_utilities.dart' as list_utils;

class Tool {
  final dynamic value;

  Tool(this.value);
}

class JsonTool {
  final Object value;

  JsonTool(this.value);

  bool _canMap(Map i) {
    bool can = true;
    for (var k in i.keys) {
      if (k is! String) return false;
      if (i[k] is Map) {
        bool next = _canMap(i[k]);
        if (next == false) can = false;
      }
    }
    return can;
  }

  bool canMap() {
    if (value is! Map) return false;
    return _canMap(value);
  }

  MapTool toMap() {
    if (canMap()) return null;
    var m = Caster(value).toType<Map>();
    return m == null ? null : MapTool(m);
  }
}

class MapTool {
  final Map<String, Object> value;

  MapTool(this.value);

  bool get _noVal => value == null;

  Tool grab(List<String> pathToField) {
    if (_noVal) return null;
    var r = map_utils.grab(value, pathToField);
    return r == null ? null : Tool(r);
  }

  MapTool pick(List<String> fields, {bool partial: false}) {
    if (_noVal) return null;
    var r = map_utils.pick(value, fields, partial: partial);
    return r == null ? null : MapTool(r);
  }

  T find<T>(String field) {
    if (_noVal) return null;
    var r = map_utils.find<T>(value, field);
    return r == null ? null : r;
  }

  MapTool scan(map_utils.ScanFunction func) {
    if (_noVal) return null;
    var r = map_utils.scan(value, func);
    return r == null ? null : MapTool(r);
  }
}

class ListTool {
  final List<Map<String, Object>> value;

  ListTool(this.value);

  bool get _noVal => value == null;

  ListTool pluck(List<String> fields, {bool partial: false}) {
    if (_noVal) return null;
    var r = list_utils.pluck(value, fields, partial: partial);
    return r == null ? null : ListTool(r);
  }

  ListTool keepIf(List<String> pathToField, Object value) {
    if (_noVal) return null;
    var r = list_utils.keepIf(value, pathToField, value);
    return r == null ? null : ListTool(r);
  }
}
