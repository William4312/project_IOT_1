import 'package:flutter/material.dart';
import 'package:project_01/app_project002/dice_roller.dart';

var startAligment = Alignment.topLeft;
var endAligment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, required this.colors});
  GradientContainer.purple({super.key})
      : colors = [Colors.deepPurple, Colors.indigo];

  final List<Color> colors;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: startAligment,
          end: endAligment,
        ),
      ),
      child: const DiceRoller(),
    );
  }
}