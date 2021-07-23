import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stopwatch/bloc/history_detail/history_detail.dart';
import 'package:stopwatch/model/history.dart';
import 'package:stopwatch/repository/history_repository.dart';

import 'history_detail_bloc_test.mocks.dart';

@GenerateMocks([HistoryRepository])
void main() {
  late HistoryDetailBloc historyDetailBloc;
  late MockHistoryRepository mockHistoryRepository;
  final dummyHistoryKey = 1;
  final dummyHistory = History(dummyHistoryKey, DateTime.now(), true);
  setUp(() {
    mockHistoryRepository = MockHistoryRepository();
    historyDetailBloc = HistoryDetailBloc(mockHistoryRepository);
  });

  group('HistoryBloc', () {
    blocTest<HistoryDetailBloc, HistoryDetailState>(
      'fetch',
      build: () {
        when(mockHistoryRepository.getHistory(dummyHistoryKey))
            .thenAnswer((_) => Future.value(dummyHistory));
        return historyDetailBloc;
      },
      act: (bloc) {
        bloc.add(HistoryDetailFetched(dummyHistoryKey));
      },
      expect: () => <HistoryDetailState>[HistoryDetailLoading(dummyHistory)],
    );
    blocTest<HistoryDetailBloc, HistoryDetailState>('delete', build: () {
      when(mockHistoryRepository.getHistory(dummyHistoryKey))
          .thenAnswer((_) => Future.value(dummyHistory));
      return historyDetailBloc;
    }, act: (bloc) {
      bloc.add(HistoryDetailDeleted(dummyHistoryKey));
    }, verify: (_) {
      verify(mockHistoryRepository.deleteHistory(dummyHistoryKey));
    });
  });
}
