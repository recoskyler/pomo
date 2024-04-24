import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/timer/timer.dart';
import 'package:pomo/widgets/timer_progress.dart';
import 'package:pomo/widgets/timer_text.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();

    return BlocProvider(
      create: (_) => TimerCubit(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<TimerCubit, TimerState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              player.play(AssetSource('sounds/pop.aac'));
            },
          ),
          BlocListener<TimerCubit, TimerState>(
            listenWhen: (previous, current) => previous.lap != current.lap,
            listener: (context, state) {
              player.play(AssetSource('sounds/ding_dong.aac'));
            },
          ),
        ],
        child: const TimerView(),
      ),
    );
  }
}

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      context.read<TimerCubit>().tick();
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Center(child: TimerProgress()),
              const Center(child: TimerText()),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
