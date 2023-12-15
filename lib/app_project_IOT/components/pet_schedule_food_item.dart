import 'package:flutter/material.dart';
import 'package:project_01/app_project_IOT/model/pet_feeder_model.dart';

class PetScheduleFoodItems extends StatelessWidget {
  const PetScheduleFoodItems({super.key, required this.petScheduleItems});
  final PetFeederModel petScheduleItems;

  @override
  Widget build(BuildContext context) {
    String formatTimeOfDay(TimeOfDay timeOfDay) {
      int hour = timeOfDay.hourOfPeriod;
      int minute = timeOfDay.minute;

      String period = timeOfDay.period == DayPeriod.am ? 'am' : 'pm';

      String formattedTime =
          '$hour:${minute.toString().padLeft(2, '0')} $period';

      return formattedTime;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(
                petScheduleItems.timeFeed.toString(),
                style: const TextStyle(fontSize: 14),
              ),
              const Spacer(),
              Text(formatTimeOfDay(petScheduleItems.time))
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(
                'X${petScheduleItems.amount}',
              ),
              const Spacer(),
              Text(petScheduleItems.formattedDate)
            ],
          )
        ]),
      ),
    );
  }
}
