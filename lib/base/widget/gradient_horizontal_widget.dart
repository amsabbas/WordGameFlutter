import 'package:flutter/material.dart';

class GradientHorizontalWidget extends StatelessWidget {
  final List<Color> colors;

  const GradientHorizontalWidget({Key? key, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors,
            begin: const Alignment(-1.0, 0.0),
            end: const Alignment(1.0, 1.0),
            stops: const [-1.0,0.0,0.5, 1.0],
            tileMode: TileMode.decal),
      ),
    );
  }
}
