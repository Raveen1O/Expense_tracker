import 'package:expenses_tracker/expenseList.dart';
import 'package:expenses_tracker/models/expenses.dart';
import 'package:expenses_tracker/newExpense.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/chart.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() {
    return _Expense();
  }
}

class _Expense extends State<ExpenseTracker> {
  final List<Expenses> _registeredExpenses = [
    Expenses(
        title: "car",
        amount: 123450.65,
        values: Category.travel,
        date: DateTime.now())
  ];

  void addExpense() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAdd: addList));
  }

  void addList(Expenses expenses) {
    setState(() {
      _registeredExpenses.add(expenses);
    });
  }

  void removeList(Expenses expenses) {
    final eleIndex = _registeredExpenses.indexOf(expenses);
    setState(() {
      _registeredExpenses.remove(expenses);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text("Item has been deleted"),
        duration: const Duration(seconds: 3),
          action: SnackBarAction(label: "Undo", onPressed:(){
            setState(() {
              _registeredExpenses.insert(eleIndex,expenses);
            });

    }
          ),
        )
    );
  }

  @override
  Widget build(context) {
    Widget content = const Center(child: Text("List is currently empty.."));
    if (_registeredExpenses.isNotEmpty) {
      content = ExpenseList(expense: _registeredExpenses, onRemove: removeList);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter expense tracker",style: TextStyle(fontSize: 20)),
          actions: [
            IconButton(onPressed: addExpense, icon: const Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            Chart(expenses:_registeredExpenses),
            Expanded(child: content)
          ],
        ));
  }
}
