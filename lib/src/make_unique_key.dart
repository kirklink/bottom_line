import 'package:uuid/uuid.dart';

String makeUuid4Key() {
  Uuid uuid = new Uuid();
  return uuid.v4().toString();
}
