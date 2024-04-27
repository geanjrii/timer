import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/feature_layer/timer/timer.dart';

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final formattedTime = duration.formatMinutesAndSeconds();
    return Text(
      formattedTime,
      style: Theme.of(context)
          .textTheme
          .displayLarge
          ?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}

extension DurationFormatedToString on int {
  String formatMinutesAndSeconds() {
    final minutesStr = ((this / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (this % 60).toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }
}
