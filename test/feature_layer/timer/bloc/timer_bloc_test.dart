// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timer/data_layer/ticker.dart';
import 'package:timer/feature_layer/timer/timer.dart';

class MockTicker extends Mock implements Ticker {}

void main() {
  group('TimerBloc', () {
    late Ticker ticker;

    setUp(() {
      ticker = MockTicker();
    });

    TimerBloc buildBloc() => TimerBloc(ticker: ticker);

    test('initial state is TimerInitial(60)', () {
      expect(
        TimerBloc(ticker: ticker).state,
        TimerInitial(60),
      );
    });

    group('TimerStarted', () {
      blocTest<TimerBloc, TimerState>(
        'emits TickerRunInProgress 5 times after timer started',
        setUp: () {
          when(() => ticker.tick(ticks: 5)).thenAnswer(
            (_) => Stream<int>.fromIterable([5, 4, 3, 2, 1]),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const TimerStarted(duration: 5)),
        expect: () => [
          TimerRunInProgress(5),
          TimerRunInProgress(4),
          TimerRunInProgress(3),
          TimerRunInProgress(2),
          TimerRunInProgress(1),
        ],
        verify: (_) => verify(() => ticker.tick(ticks: 5)).called(1),
      );

      blocTest<TimerBloc, TimerState>(
        'emits [TimerRunInProgress(3)] when timer ticks to 3',
        setUp: () {
          when(() => ticker.tick(ticks: 3)).thenAnswer(
            (_) => Stream<int>.value(3),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(TimerStarted(duration: 3)),
        expect: () => [TimerRunInProgress(3)],
      );

      blocTest<TimerBloc, TimerState>(
        'emits [TimerRunInProgress(1), TimerRunComplete()] when timer ticks to 0',
        setUp: () {
          when(() => ticker.tick(ticks: 1)).thenAnswer(
            (_) => Stream<int>.fromIterable([1, 0]),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(TimerStarted(duration: 1)),
        expect: () => [TimerRunInProgress(1), TimerRunComplete()],
      );
    });
    group('TimerPaused', () {
      blocTest<TimerBloc, TimerState>(
        'emits [TickerRunPause(2)] when ticker is paused at 2',
        build: buildBloc,
        seed: () => TimerRunInProgress(2),
        act: (bloc) => bloc.add(TimerPaused()),
        expect: () => [TimerRunPause(2)],
      );
    });

    group('TimerResumed', () {
      blocTest<TimerBloc, TimerState>(
        'emits [TickerRunInProgress(5)] when ticker is resumed at 5',
        build: buildBloc,
        seed: () => TimerRunPause(5),
        act: (bloc) => bloc.add(TimerResumed()),
        expect: () => [TimerRunInProgress(5)],
      );
    });

    group('TimerReset', () {
      blocTest<TimerBloc, TimerState>(
        'emits [TickerInitial(60)] when timer is restarted',
        build: buildBloc,
        act: (bloc) => bloc.add(TimerReset()),
        expect: () => [TimerInitial(60)],
      );
    });
  });
}
