import 'package:flutter_test/flutter_test.dart';
import 'package:timer/feature_layer/timer/bloc/timer_bloc.dart';

void main() {
  group('TimerEvent', () {
    group('TimerStarted', () {
      test('TimerStarted should have correct duration', () {
        const event = TimerStarted(duration: 60);
        expect(event.duration, 60);
      });
    });
    group('TimerPaused', () {
      test('TimerPaused should not have any properties', () {
        const event = TimerPaused();
        expect(event, isA<TimerEvent>());
      });
    });

    group('TimerResumed', () {
      test('TimerResumed should not have any properties', () {
        const event = TimerResumed();
        expect(event, isA<TimerEvent>());
      });
    });

    group('TimerReset', () {
      test('TimerReset should not have any properties', () {
        const event = TimerReset();
        expect(event, isA<TimerEvent>());
      });
    });
  });
}
