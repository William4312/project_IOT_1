import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum TimeFeed { morning, afternoon, evening, night }


class PetFeederModel {
  PetFeederModel(
      {required this.amount,
      required this.date,
      required this.time,
      required this.timeFeed})
      : id = uuid.v4();

  final String id;
  final int amount;
  final DateTime date;
  final TimeOfDay time;
  final TimeFeed timeFeed;

  String get formattedDate {
    return formatter.format(date);
  }
}
