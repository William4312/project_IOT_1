import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.tempText, {super.key});
  
  final String tempText;

  @override
  Widget build(BuildContext context) {
    return Text(
      tempText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28.0,
      ),
    );
  }
}
