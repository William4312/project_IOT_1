import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({super.key, required this.answer, required this.onTap});
  final String answer;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 40,
            ),
          ),
          backgroundColor: const MaterialStatePropertyAll(
            Color.fromARGB(
              255,
              33,
              1,
              95,
            ),
          ),
          foregroundColor: const MaterialStatePropertyAll(
            Colors.white,
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                40,
              ),
            ),
          )),
      child: Text(
        answer,
        textAlign: TextAlign.center,
      ),
    );
  }
}
