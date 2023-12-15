import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_01/app_project_IOT/components/graph_data.dart';
import 'package:project_01/app_project_IOT/components/new_pet_food_schedule.dart';
import 'package:project_01/app_project_IOT/components/pet_schedule_food_list.dart';
import 'package:project_01/app_project_IOT/model/pet_feeder_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static double sensorReading = 788.0;
  static double minValue = 0.0;
  static double maxValue = 20.0;

  static double calculatePercentage(
      double sensorValue, double minValue, double maxValue) {
    sensorValue = sensorValue.clamp(minValue, maxValue);
    double percentage =
        ((sensorValue - minValue) / (maxValue - minValue)) * 100.0;
    return percentage.clamp(0.0, 100.0);
  }

  double percentage = calculatePercentage(sensorReading, minValue, maxValue);

  double? food;
  double? drink;
  final List<PetFeederModel> _registerPetFeeder = [
    PetFeederModel(
      amount: 2,
      date: DateTime.now(),
      time: const TimeOfDay(hour: 12, minute: 20),
      timeFeed: TimeFeed.evening,
    ),
    PetFeederModel(
      amount: 10,
      date: DateTime.now(),
      time: const TimeOfDay(hour: 15, minute: 20),
      timeFeed: TimeFeed.morning,
    ),
    PetFeederModel(
      amount: 3,
      date: DateTime.now(),
      time: const TimeOfDay(hour: 15, minute: 20),
      timeFeed: TimeFeed.afternoon,
    ),
    PetFeederModel(
      amount: 7,
      date: DateTime.now(),
      time: const TimeOfDay(hour: 15, minute: 20),
      timeFeed: TimeFeed.night,
    ),
    PetFeederModel(
      amount: 9,
      date: DateTime.now(),
      time: const TimeOfDay(hour: 15, minute: 20),
      timeFeed: TimeFeed.night,
    ),
  ];

  void _addPetScheduleFood(PetFeederModel petFeederSchedule) {
    setState(() {
      _registerPetFeeder.add(petFeederSchedule);
    });
  }

  void _openAddPetScheduleOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewPetFoodSchedule(
          onAddPetFoodSchedule: _addPetScheduleFood,
        );
      },
    );
  }

  void _removePetScheduleFood(PetFeederModel petFeederSchedule) {
    final expenseIndex = _registerPetFeeder.indexOf(petFeederSchedule);
    setState(() {
      _registerPetFeeder.remove(petFeederSchedule);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text(
          'Expense deleted',
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            setState(() {
              _registerPetFeeder.insert(expenseIndex, petFeederSchedule);
            });
          },
        ),
      ),
    );
  }

  Future<void> firebaseData() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('schedule/food');

    DatabaseReference starCountRefDrink =
        FirebaseDatabase.instance.ref('schedule/drink');

    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateStarCountFood(data.toString());
    });

    starCountRefDrink.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateStarCountDrink(data.toString());
    });
  }

  void updateStarCountFood(String data) {
    setState(() {
      food = double.tryParse(data);
    });
  }

  void updateStarCountDrink(String data) {
    setState(() {
      drink = double.tryParse(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget maiContent = const Center(
      child: Text('No Expenses found. Start adding some!'),
    );
    if (_registerPetFeeder.isNotEmpty) {
      maiContent = PetScheduleFoodList(
          onRemovePetSchedule: _removePetScheduleFood,
          petScheduleFoodData: _registerPetFeeder);
    }

    firebaseData();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule Screen',
          style: GoogleFonts.roboto(
            fontSize: 14,
          ),
        ),
        shadowColor: Colors.black54,
        actions: [
          TextButton.icon(
            onPressed: _openAddPetScheduleOverlay,
            icon: const Icon(Icons.edit_calendar_sharp),
            label: const Text(
              'Add Schedule',
            ),
          ),
        ],
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GraphData(data: _registerPetFeeder),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 80,
                      lineWidth: 25,
                      percent: 0.4,
                      progressColor: Colors.deepPurple,
                      backgroundColor: Colors.deepPurple.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        calculatePercentage(food!, minValue, maxValue)
                            .toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('food : ${food?.toStringAsFixed(2)}'),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 80,
                      lineWidth: 25,
                      percent: 0.4,
                      progressColor: Colors.deepPurple,
                      backgroundColor: Colors.deepPurple.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        calculatePercentage(drink!, minValue, maxValue)
                            .toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('drink : ${drink?.toStringAsFixed(2)}'),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'List of schedule food',
              textAlign: TextAlign.start,
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(child: maiContent),
          ],
        ),
      ),
    );
  }
}
