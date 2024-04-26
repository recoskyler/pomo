import 'package:flutter/material.dart';

class CustomTime extends StatelessWidget {
  const CustomTime({
    required this.duration,
    this.fontFamily,
    this.style,
    super.key,
  });

  final String duration;
  final String? fontFamily;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      duration,
      style: (style ?? Theme.of(context).textTheme.displayLarge)!.copyWith(
        fontFamily: fontFamily,
      ),
    );
  }
}
