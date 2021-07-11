class MyStopwatch {
  int _start = 0;
  int? _stop = 0;
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

  int get elapsedMilliseconds => _now() - _start;

  int _now() => DateTime.now().millisecondsSinceEpoch;
}
