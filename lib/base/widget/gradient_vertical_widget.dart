import 'package:flutter/material.dart';

class GradientVerticalWidget extends StatelessWidget {
  final List<Color> colors;

  const GradientVerticalWidget({Key? key, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            tileMode: TileMode.clamp),
      ),
    );
  }
}
