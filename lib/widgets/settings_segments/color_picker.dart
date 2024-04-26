import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/pages/settings/cubit/settings_cubit.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.redAccent,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
    ];

    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) => previous.colorSeed != current.colorSeed,
      builder: (context, state) {
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 8,
          spacing: 8,
          alignment: WrapAlignment.center,
          children: colors.map((e) {
            return GestureDetector(
              onTap: () => context.read<SettingsCubit>().setColorSeed(e),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: e,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  if (state.colorSeed?.value == e.value)
                    const Icon(
                      Icons.circle,
                      // shadows: [BoxShadow(blurRadius: 3)],
                    ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
