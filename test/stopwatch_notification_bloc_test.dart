import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stopwatch/bloc/stopwatch_notification/stopwatch_notification.dart';
import 'package:stopwatch/bloc/stopwatch_notification/stopwatch_notification_bloc.dart';
import 'package:stopwatch/notification/notification_helper.dart';
import 'package:stopwatch/notification/android_notification_details_wrapper.dart';

import 'stopwatch_notification_bloc_test.mocks.dart';

@GenerateMocks([NotificationHelper])
void main() {
  late StopwatchNotificationBloc bloc;
  late MockNotificationHelper notificationHelper;

  setUp(() {
    notificationHelper = MockNotificationHelper();
    bloc = StopwatchNotificationBloc(notificationHelper);
  });

  final AndroidNotificationDetailsWrapper notificationDetails =
      StopwatchNotificationBloc.notificationDetails;

  group('StopwatchNotificationBloc', () {
    final int dummyMsec = 70000; // 01:10
    final String displayText = '01:10';

    blocTest<StopwatchNotificationBloc, StopwatchNotificationState>(
      'show 01:10',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(StopwatchNotificationShowed(dummyMsec)),
      expect: () =>
          const <StopwatchNotificationState>[StopwatchNotificationShowing()],
      verify: (_) {
        verify(notificationHelper.show(
            notificationDetails,
            StopwatchNotificationBloc.notificationId,
            argThat(contains(displayText)),
            StopwatchNotificationBloc.body));
      },
    );
    blocTest<StopwatchNotificationBloc, StopwatchNotificationState>(
      'hide',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(StopwatchNotificationHided()),
      expect: () =>
          const <StopwatchNotificationState>[StopwatchNotificationHiding()],
      verify: (_) {
        verify(notificationHelper
            .cancel(StopwatchNotificationBloc.notificationId));
      },
    );

    blocTest<StopwatchNotificationBloc, StopwatchNotificationState>(
      'show -> hide -> show',
      build: () {
        return bloc;
      },
      act: (bloc) {
        bloc.add(StopwatchNotificationShowed(dummyMsec));
        bloc.add(StopwatchNotificationHided());
        bloc.add(StopwatchNotificationShowed(dummyMsec));
      },
      expect: () => const <StopwatchNotificationState>[
        StopwatchNotificationShowing(),
        StopwatchNotificationHiding(),
        StopwatchNotificationShowing(),
      ],
      verify: (_) {
        verifyInOrder([
          notificationHelper.show(
              notificationDetails,
              StopwatchNotificationBloc.notificationId,
              argThat(contains(displayText)),
              StopwatchNotificationBloc.body),
          notificationHelper.cancel(StopwatchNotificationBloc.notificationId),
          notificationHelper.show(
              notificationDetails,
              StopwatchNotificationBloc.notificationId,
              argThat(contains(displayText)),
              StopwatchNotificationBloc.body),
        ]);
      },
    );

    blocTest<StopwatchNotificationBloc, StopwatchNotificationState>(
      'show 55:55',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(StopwatchNotificationShowed(3355000)),
      expect: () =>
          const <StopwatchNotificationState>[StopwatchNotificationShowing()],
      verify: (_) {
        verify(notificationHelper.show(
            notificationDetails,
            StopwatchNotificationBloc.notificationId,
            argThat(contains('55:55')),
            StopwatchNotificationBloc.body));
      },
    );

    blocTest<StopwatchNotificationBloc, StopwatchNotificationState>(
      'show 111:11',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(StopwatchNotificationShowed(6671000)),
      expect: () =>
          const <StopwatchNotificationState>[StopwatchNotificationShowing()],
      verify: (_) {
        verify(notificationHelper.show(
            notificationDetails,
            StopwatchNotificationBloc.notificationId,
            argThat(contains('111:11')),
            StopwatchNotificationBloc.body));
      },
    );

    final oneSecondMsec = 1000;
    final twoSecondMsec = 2000;
    final threeSecondMsec = 3000;
    final oneSecondDisplayText = '00:01';
    final twoSecondDisplayText = '00:02';
    final threeSecondDisplayText = '00:03';

    blocTest<StopwatchNotificationBloc, StopwatchNotificationState>(
      'show(one second) -> show(two second) -> show(three seconds) -> hide -> show(one second) -> show(two second) -> show(three seconds)',
      build: () {
        return bloc;
      },
      act: (bloc) {
        bloc.add(StopwatchNotificationShowed(oneSecondMsec));
        bloc.add(StopwatchNotificationShowed(twoSecondMsec));
        bloc.add(StopwatchNotificationShowed(threeSecondMsec));
        bloc.add(StopwatchNotificationHided());
        bloc.add(StopwatchNotificationShowed(oneSecondMsec));
        bloc.add(StopwatchNotificationShowed(twoSecondMsec));
        bloc.add(StopwatchNotificationShowed(threeSecondMsec));
      },
      expect: () => const <StopwatchNotificationState>[
        StopwatchNotificationShowing(),
        StopwatchNotificationHiding(),
        StopwatchNotificationShowing()
      ],
      verify: (_) {
        verifyInOrder([
          notificationHelper.show(
              notificationDetails,
              StopwatchNotificationBloc.notificationId,
              argThat(contains(oneSecondDisplayText)),
              StopwatchNotificationBloc.body),
          notificationHelper.show(
              notificationDetails,
              StopwatchNotificationBloc.notificationId,
              argThat(contains(twoSecondDisplayText)),
              StopwatchNotificationBloc.body),
          notificationHelper.show(
              notificationDetails,
              StopwatchNotificationBloc.notificationId,
              argThat(contains(threeSecondDisplayText)),
              StopwatchNotificationBloc.body),
          notificationHelper.cancel(StopwatchNotificationBloc.notificationId),
          notificationHelper.show(
              notificationDetails,
              StopwatchNotificationBloc.notificationId,
              argThat(contains(oneSecondDisplayText)),
              StopwatchNotificationBloc.body),
          notificationHelper.show(
              notificationDetails,
              StopwatchNotificationBloc.notificationId,
              argThat(contains(twoSecondDisplayText)),
              StopwatchNotificationBloc.body),
          notificationHelper.show(
              notificationDetails,
              StopwatchNotificationBloc.notificationId,
              argThat(contains(threeSecondDisplayText)),
              StopwatchNotificationBloc.body),
        ]);
      },
    );
  });
}
