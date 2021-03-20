import 'dart:async';

class Replicator {
  Duration _duration;
  Timer _updater;

  Replicator(Duration duration) : _duration = duration;

  void start(void callback()) {
    _updater = Timer.periodic(_duration, (_) => callback());
  }

  void stop() {
    _updater.cancel();
    _updater = null;
  }
}
