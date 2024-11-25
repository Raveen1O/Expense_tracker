import 'dart:math';

import 'package:expenses_tracker/expenseItem.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expenses.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expense, required this.onRemove});

  final List<Expenses> expense;
  final void Function(Expenses) onRemove;

  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expense.length,
        itemBuilder: (ctx, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.5),
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal
              ),
            ),
            key: ValueKey(expense[index]),
            onDismissed: (direction) {
              onRemove(expense[index]);
            },
            child: ExpenseItem(expense[index])));
  }
}
