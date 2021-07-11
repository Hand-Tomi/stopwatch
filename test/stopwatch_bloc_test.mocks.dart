// Mocks generated by Mockito 5.0.10 from annotations
// in stopwatch/test/stopwatch_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:stopwatch/database/table.dart' as _i2;
import 'package:stopwatch/model/history.dart' as _i6;
import 'package:stopwatch/model/lap.dart' as _i7;
import 'package:stopwatch/repository/history_repository.dart' as _i4;
import 'package:stopwatch/util/replicator.dart' as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeDuration extends _i1.Fake implements Duration {
  @override
  String toString() => super.toString();
}

class _FakeTable<T> extends _i1.Fake implements _i2.Table<T> {}

/// A class which mocks [Stopwatch].
///
/// See the documentation for Mockito's code generation for more information.
class MockStopwatch extends _i1.Mock implements Stopwatch {
  MockStopwatch() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get frequency =>
      (super.noSuchMethod(Invocation.getter(#frequency), returnValue: 0)
          as int);
  @override
  int get elapsedTicks =>
      (super.noSuchMethod(Invocation.getter(#elapsedTicks), returnValue: 0)
          as int);
  @override
  Duration get elapsed => (super.noSuchMethod(Invocation.getter(#elapsed),
      returnValue: _FakeDuration()) as Duration);
  @override
  int get elapsedMicroseconds => (super
          .noSuchMethod(Invocation.getter(#elapsedMicroseconds), returnValue: 0)
      as int);
  @override
  int get elapsedMilliseconds => (super
          .noSuchMethod(Invocation.getter(#elapsedMilliseconds), returnValue: 0)
      as int);
  @override
  bool get isRunning =>
      (super.noSuchMethod(Invocation.getter(#isRunning), returnValue: false)
          as bool);
  @override
  void start() => super.noSuchMethod(Invocation.method(#start, []),
      returnValueForMissingStub: null);
  @override
  void stop() => super.noSuchMethod(Invocation.method(#stop, []),
      returnValueForMissingStub: null);
  @override
  void reset() => super.noSuchMethod(Invocation.method(#reset, []),
      returnValueForMissingStub: null);
}

/// A class which mocks [Replicator].
///
/// See the documentation for Mockito's code generation for more information.
class MockReplicator extends _i1.Mock implements _i3.Replicator {
  MockReplicator() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void start(void Function()? callback) =>
      super.noSuchMethod(Invocation.method(#start, [callback]),
          returnValueForMissingStub: null);
  @override
  void stop() => super.noSuchMethod(Invocation.method(#stop, []),
      returnValueForMissingStub: null);
}

/// A class which mocks [HistoryRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockHistoryRepository extends _i1.Mock implements _i4.HistoryRepository {
  MockHistoryRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Table<_i6.History>> getTable() => (super.noSuchMethod(
          Invocation.method(#getTable, []),
          returnValue:
              Future<_i2.Table<_i6.History>>.value(_FakeTable<_i6.History>()))
      as _i5.Future<_i2.Table<_i6.History>>);
  @override
  _i5.Future<Iterable<_i6.History>> getHistorys() =>
      (super.noSuchMethod(Invocation.method(#getHistorys, []),
              returnValue: Future<Iterable<_i6.History>>.value([]))
          as _i5.Future<Iterable<_i6.History>>);
  @override
  _i5.Future<_i6.History?> getHistory(dynamic key) => (super.noSuchMethod(
      Invocation.method(#getHistory, [key]),
      returnValue: Future<_i6.History?>.value()) as _i5.Future<_i6.History?>);
  @override
  _i5.Future<void> deleteHistory(dynamic key) =>
      (super.noSuchMethod(Invocation.method(#deleteHistory, [key]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  bool isCurrentHistory() =>
      (super.noSuchMethod(Invocation.method(#isCurrentHistory, []),
          returnValue: false) as bool);
  @override
  void renewCurrentHistory() =>
      super.noSuchMethod(Invocation.method(#renewCurrentHistory, []),
          returnValueForMissingStub: null);
  @override
  void clearCurrentHistory() =>
      super.noSuchMethod(Invocation.method(#clearCurrentHistory, []),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> overwriteLapsInCurrentHistory(List<_i7.Lap>? laps) => (super
      .noSuchMethod(Invocation.method(#overwriteLapsInCurrentHistory, [laps]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> overwriteTimesInCurrentHistory(int? msec) => (super
      .noSuchMethod(Invocation.method(#overwriteTimesInCurrentHistory, [msec]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
}
