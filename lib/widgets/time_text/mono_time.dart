import 'package:flutter/material.dart';

class MonoTime extends StatelessWidget {
  const MonoTime({
    required this.duration,
    this.style,
    super.key,
  });

  final String duration;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final mins = duration.split(':').first;
    final secs = duration.split(':').last;

    return RichText(
      text: TextSpan(
        style: (style ?? Theme.of(context).textTheme.displayLarge)!.copyWith(
          fontFamily: 'Roboto Mono',
        ),
        children: [
          TextSpan(text: mins),
          TextSpan(
            text: ':',
            style: style ?? Theme.of(context).textTheme.displayLarge,
          ),
          TextSpan(text: secs),
        ],
      ),
    );
  }
}
