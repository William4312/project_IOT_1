import 'package:flutter/material.dart';
import 'package:project_01/app_project_IOT/model/pet_feeder_model.dart';

class NewPetFoodSchedule extends StatefulWidget {
  const NewPetFoodSchedule({super.key, required this.onAddPetFoodSchedule});
  final void Function(PetFeederModel petFoodSchedule) onAddPetFoodSchedule;

  @override
  State<NewPetFoodSchedule> createState() => _NewPetFoodScheduleState();
}

class _NewPetFoodScheduleState extends State<NewPetFoodSchedule> {
  final _amountController = TextEditingController();

  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;
  TimeFeed _selectedTimeFeed = TimeFeed.morning;

  void _selectTime() async {
    final now = TimeOfDay.now();
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: now,
    );
    if (newTime != null) {
      setState(() {
        _selectedTime = newTime;
      });
    }
  }

  void _selectedTimeFeedMode(TimeOfDay data) {
    if (data.hour <= const TimeOfDay(hour: 10, minute: 0).hour) {
      _selectedTimeFeed = TimeFeed.morning;
    } else if (data.hour <= const TimeOfDay(hour: 14, minute: 0).hour &&
        data.hour >= const TimeOfDay(hour: 10, minute: 0).hour) {
      _selectedTimeFeed = TimeFeed.afternoon;
    } else if (data.hour <= const TimeOfDay(hour: 17, minute: 0).hour &&
        data.hour >= const TimeOfDay(hour: 14, minute: 0).hour) {
      _selectedTimeFeed = TimeFeed.evening;
    } else {
      _selectedTimeFeed = TimeFeed.night;
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmout = int.tryParse(_amountController.text);
    final amoutIsInvalid = enteredAmout == null || enteredAmout <= 0;

    if (amoutIsInvalid || _selectedDate == null || _selectedTime == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid input'),
            content: const Text(
                'Please make sure a valid date, and category was entered'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Okay',
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    _selectedTimeFeedMode(_selectedTime!);

    widget.onAddPetFoodSchedule(
      PetFeederModel(
          amount: enteredAmout,
          date: _selectedDate!,
          time: _selectedTime!,
          timeFeed: _selectedTimeFeed),
    );
    
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

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

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Amount'), suffixIcon: Icon(Icons.close)),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No date selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_selectedTime == null
                  ? 'No time selected'
                  : formatTimeOfDay(_selectedTime!)),
              IconButton(
                onPressed: _selectTime,
                icon: const Icon(
                  Icons.timer_sharp,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                },
                child: const Text(
                  'Save Expenses',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
