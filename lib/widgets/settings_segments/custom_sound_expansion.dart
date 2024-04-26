import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/settings/settings.dart';

class CustomSoundExpansion extends StatelessWidget {
  const CustomSoundExpansion({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return ExpansionTile(
          title: Text(l10n.customSounds),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          shape: const Border(),
          childrenPadding: const EdgeInsets.all(16),
          children: [
            _CustomSoundField(
              initialValue: state.customWorkStartSound,
              onChanged: (value) {
                context.read<SettingsCubit>().setCustomWorkStartSound(value);
              },
              value: state.customWorkStartSound,
              title: l10n.workStartSound,
            ),
            const SizedBox(height: 16),
            _CustomSoundField(
              initialValue: state.customShortBreakStartSound,
              onChanged: (value) {
                context
                    .read<SettingsCubit>()
                    .setCustomShortBreakStartSound(value);
              },
              value: state.customShortBreakStartSound,
              title: l10n.shortBreakStartSound,
            ),
            const SizedBox(height: 16),
            _CustomSoundField(
              initialValue: state.customLongBreakStartSound,
              onChanged: (value) {
                context
                    .read<SettingsCubit>()
                    .setCustomLongBreakStartSound(value);
              },
              value: state.customLongBreakStartSound,
              title: l10n.longBreakStartSound,
            ),
            const SizedBox(height: 16),
            _CustomSoundField(
              initialValue: state.customWorkEndSound,
              onChanged: (value) {
                context.read<SettingsCubit>().setCustomWorkEndSound(value);
              },
              value: state.customWorkEndSound,
              title: l10n.workEndSound,
            ),
            const SizedBox(height: 16),
            _CustomSoundField(
              initialValue: state.customShortBreakEndSound,
              onChanged: (value) {
                context
                    .read<SettingsCubit>()
                    .setCustomShortBreakEndSound(value);
              },
              value: state.customShortBreakEndSound,
              title: l10n.shortBreakEndSound,
            ),
            const SizedBox(height: 16),
            _CustomSoundField(
              initialValue: state.customLongBreakEndSound,
              onChanged: (value) {
                context.read<SettingsCubit>().setCustomLongBreakEndSound(value);
              },
              value: state.customLongBreakEndSound,
              title: l10n.longBreakEndSound,
            ),
          ],
        );
      },
    );
  }
}

class _CustomSoundField extends StatefulWidget {
  const _CustomSoundField({
    required this.onChanged,
    this.initialValue,
    this.title = 'Custom Sound',
    // ignore: unused_element
    this.hintText = '/home/user/sounds/example.mp3',
    this.value = '',
  });

  final String? initialValue;
  final String title;
  final String hintText;
  final String value;
  final void Function(String) onChanged;

  @override
  State<_CustomSoundField> createState() => _CustomSoundFieldState();
}

class _CustomSoundFieldState extends State<_CustomSoundField> {
  late TextEditingController _controller;
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();

    _player = AudioPlayer();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();

    super.dispose();
  }

  Widget _buildButton(BuildContext context) {
    if (widget.value.trim().isEmpty) {
      return IconButton(
        onPressed: () {
          FilePicker.platform.pickFiles(type: FileType.audio).then((value) {
            if (value != null) {
              _controller.text = value.files.single.path!;

              Logger().i('Selected file: ${value.files.single.path}');

              widget.onChanged(value.files.single.path!);
            }
          });
        },
        icon: const Icon(Icons.folder),
      );
    }

    return IconButton(
      onPressed: () {
        if (_player.state == PlayerState.playing) {
          _player.stop();
        } else {
          _player.play(DeviceFileSource(widget.value));
        }
      },
      icon: Icon(
        _player.state == PlayerState.playing ? Icons.stop : Icons.play_arrow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: const OutlineInputBorder(),
            prefixIcon: StreamBuilder(
              stream: _player.onPlayerStateChanged,
              builder: (context, _) => _buildButton(context),
            ),
            suffixIcon: widget.value.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      widget.onChanged('');
                      _controller.text = '';
                    },
                    icon: const Icon(Icons.clear),
                  ),
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
