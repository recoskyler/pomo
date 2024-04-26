import 'package:flutter/material.dart';

class FancyMonoTime extends StatelessWidget {
  const FancyMonoTime({
    required this.duration,
    this.style,
    super.key,
  });

  final String duration;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      duration,
      style: (style ?? Theme.of(context).textTheme.displayLarge)!.copyWith(
        fontFamily: 'Major Mono Display',
      ),
    );
  }
}
