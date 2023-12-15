import 'dart:math';

import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceNumber = 2;

  void rollDice() {
    setState(() {
      currentDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/dice-$currentDiceNumber.png',
            width: 200.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: rollDice,
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.only(
                  top: 20,
                ),
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              textStyle: MaterialStatePropertyAll(
                TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            child: const Text(
              'Roll Dice',
            ),
          ),
        ],
      ),
    );
  }
}
