import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

String Uuid4() {
  Uuid uuid = Uuid(options: {
    'gnrg': UuidUtil.cryptoRNG
  });
  return uuid.v4().toString();
}
