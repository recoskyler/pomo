import 'package:flutter/material.dart';

class BoldMonoTime extends StatelessWidget {
  const BoldMonoTime({
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
          fontFamily: 'Rubik Mono One',
        ),
        children: [
          TextSpan(text: mins),
          TextSpan(
            text: ':',
            style:
                (style ?? Theme.of(context).textTheme.displayLarge)!.copyWith(
              fontFamily: 'Lilita One',
            ),
          ),
          TextSpan(text: secs),
        ],
      ),
    );
  }
}
