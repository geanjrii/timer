import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/feature_layer/timer/timer.dart';

class ButtonHub extends StatelessWidget {
  const ButtonHub({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => const [StartButton()],
              TimerRunInProgress() => const [PauseButton(), ResetButton()],
              TimerRunPause() => const [ResumeButton(), ResetButton()],
              TimerRunComplete() => const [ResetButton()]
            },
          ],
        );
      },
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timerBloc = context.read<TimerBloc>();
    return FloatingActionButton(
      child: const Icon(Icons.play_arrow),
      onPressed: () => timerBloc.add(const TimerStarted(duration: 60)),
    );
  }
}

class PauseButton extends StatelessWidget {
  const PauseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timerBloc = context.read<TimerBloc>();
    return FloatingActionButton(
      child: const Icon(Icons.pause),
      onPressed: () => timerBloc.add(const TimerPaused()),
    );
  }
}

class ResumeButton extends StatelessWidget {
  const ResumeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timerBloc = context.read<TimerBloc>();
    return FloatingActionButton(
      child: const Icon(Icons.play_arrow),
      onPressed: () => timerBloc.add(const TimerResumed()),
    );
  }
}

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    final timerBloc = context.read<TimerBloc>();
    return FloatingActionButton(
      child: const Icon(Icons.replay),
      onPressed: () => timerBloc.add(const TimerReset()),
    );
  }
}
