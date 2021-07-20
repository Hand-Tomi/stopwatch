import 'package:stopwatch/model/current_stopwatch.dart';

class MyStopwatch {
  int _start = 0;
  int get startElapsedMilliseconds => _start;

  int? _stop = 0;
  int? get stopElapsedMilliseconds => _stop;

  void init(int start, int? stop) {
    _start = start;
    _stop = stop;
  }

  void start() {
    int? stop = _stop;
    if (stop != null) {
      _start += _now() - stop;
      _stop = null;
    }
  }

  void stop() {
    _stop ??= _now();
  }

  void reset() {
    _start = _stop ?? _now();
  }

  int get elapsedMilliseconds {
    final now = _now();
    final stop = _stop;
    if (stop != null) {
      return now - (_start + (now - stop));
    } else {
      return now - _start;
    }
  }

  int _now() => DateTime.now().millisecondsSinceEpoch;
}
