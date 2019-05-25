import 'dart:async';

class yyz implements Backoffable {
  int result;
  int _cap = 1;
  int _target = 10;

  Future<bool> backoff() async {
    print('in backoff');
    int _current;
    for (int i = 0; i < _cap; i++) {
      print(i);
      _current = i;
    }
    if (_current < _target) {
      _cap = _cap + 1;
      return false;
    } else {
      result = _current;
      return true;
    }
  }
}

void main() async {
// Future sleep1() {
//   return new Future.delayed(const Duration(seconds: 2), () => print("1"));
// }

// Future sleep2() {
//   return new Future.delayed(const Duration(seconds: 1), () => print("2"));
// }

// sleep1();
// sleep2();

  var x = yyz();

  Future<String> counter() async {
    for (int i = 0; i < 10; i++) {
      print(i);
    }
    return 'counter';
  }

  Future<void> doCount() async {
    for (int i = 0; i < 100000; i++) {
      print(await counter());
    }
  }

  exponentialBackoff(x, maxTries: 4);
  doCount();
}

abstract class Backoffable {
  FutureOr<bool> backoff();
}

Future<bool> sleep(Backoffable b, int delaySeconds) {
  print('in sleep');
  return Future.delayed(Duration(seconds: delaySeconds), () async {
    return await b.backoff();
  });
}

Future<T> exponentialBackoff<T>(Backoffable b,
    {maxTries: 10, maxTimeInSec: 60}) async {
  int tryCount = 0;
  int delay = 0;
  Stopwatch stopwatch = Stopwatch()..start();
  while (tryCount < maxTries &&
      stopwatch.isRunning &&
      stopwatch.elapsed.inSeconds < maxTimeInSec) {
    print('inside try. count: $tryCount');
    var success = await sleep(b, delay);
    if (success) {
      stopwatch.stop();
      return b as T;
    } else {
      delay = delay == 0 ? 1 : delay * 2;
      tryCount = tryCount + 1;
    }
  }
  return null;
}
