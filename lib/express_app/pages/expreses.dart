import 'package:flutter/material.dart';
import 'package:project_01/express_app/components/chart/chart.dart';
import 'package:project_01/express_app/components/expenses_list.dart';
import 'package:project_01/express_app/components/new_expense.dart';
import 'package:project_01/express_app/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.9,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.68,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(
          onAddExpense: _addExpense,
        );
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
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
          onPressed: () {
            setState(() {
              _registerExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget maiContent = const Center(
      child: Text('No Expenses found. Start adding some!'),
    );
    if (_registerExpenses.isNotEmpty) {
      maiContent = ExpensesList(
        expenses: _registerExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expenses'),
        actions: [
          IconButton(
            onPressed: _openAddExpensesOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registerExpenses,),
          Expanded(
            child: maiContent,
          ),
        ],
      ),
    );
  }
}
