import 'dart:async';

Future<T> mockServiceCall<T>({T success, bool throwError: false}) {
  if (success != null && throwError) {
    throw Exception(
        'mockServiceCall should have only a success or error option');
  }
  return new Future.delayed(const Duration(seconds: 2), () {
    if (throwError) {
      throw Error();
    } else if (success != null) {
      return success;
    } else {
      return null;
    }
  });
}
