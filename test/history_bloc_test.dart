import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stopwatch/bloc/history/history.dart';
import 'package:stopwatch/model/history.dart';
import 'package:stopwatch/repository/history_repository.dart';

import 'history_bloc_test.mocks.dart';

@GenerateMocks([HistoryRepository])
void main() {
  late HistoryBloc historyBloc;
  late MockHistoryRepository mockHistoryRepository;
  final dummyHistoryKey = 1;
  final dummyHistorys = [
    History(1, DateTime.now(), true),
    History(2, DateTime.now(), false),
    History(3, DateTime.now(), false),
  ];
  setUp(() {
    mockHistoryRepository = MockHistoryRepository();
    historyBloc = HistoryBloc(mockHistoryRepository);
  });

  group('HistoryBloc', () {
    blocTest<HistoryBloc, HistoryState>(
      'fetch',
      build: () {
        when(mockHistoryRepository.getHistorys())
            .thenAnswer((_) => Future.value(dummyHistorys));
        return historyBloc;
      },
      act: (bloc) {
        bloc.add(HistoryFetched());
      },
      expect: () => <HistoryState>[HistoryLoading(dummyHistorys)],
    );
    blocTest<HistoryBloc, HistoryState>('delete',
        build: () {
          when(mockHistoryRepository.getHistorys())
              .thenAnswer((_) => Future.value(dummyHistorys));
          return historyBloc;
        },
        act: (bloc) {
          bloc.add(HistoryDeleted(dummyHistoryKey));
        },
        expect: () => <HistoryState>[HistoryLoading(dummyHistorys)],
        verify: (_) {
          verify(mockHistoryRepository.deleteHistory(dummyHistoryKey));
        });
  });
}
