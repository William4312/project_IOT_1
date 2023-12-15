import 'package:flutter/material.dart';
import 'package:project_01/app_project_IOT/components/pet_schedule_food_item.dart';
import 'package:project_01/app_project_IOT/model/pet_feeder_model.dart';

class PetScheduleFoodList extends StatelessWidget {
  const PetScheduleFoodList({super.key, required this.onRemovePetSchedule, required this.petScheduleFoodData});

  final List<PetFeederModel> petScheduleFoodData;
  final void Function(PetFeederModel petFoodSchedule) onRemovePetSchedule;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: petScheduleFoodData.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(petScheduleFoodData[index]),
        background: Container(
          color: Colors.deepOrange.withOpacity(0.75),
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
        ),
        onDismissed: (direction) {
          onRemovePetSchedule(petScheduleFoodData[index]);
        },
        child: PetScheduleFoodItems(
          petScheduleItems: petScheduleFoodData[index],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:project_01/express_app/components/expense_item.dart';
// import 'package:project_01/express_app/models/expense.dart';

// class ExpensesList extends StatelessWidget {
//   const ExpensesList(
//       {super.key, required this.expenses, required this.onRemoveExpense});

//   final List<Expense> expenses;
//   final void Function(Expense expense) onRemoveExpense;

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
