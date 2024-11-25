import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import "package:intl/intl.dart";

final formatter = DateFormat.yMd();
const uuid = Uuid();
enum Category {food,work,leisure,travel}
const categoryIcons = {
  Category.food :Icons.lunch_dining_rounded,
  Category.work : Icons.work,
  Category.leisure : Icons.movie,
  Category.travel :Icons.flight_takeoff


};
class Expenses {
  Expenses(
      {required this.title,
      required this.amount,
      required this.values,
      required this.date
      }):id=uuid.v4();

  final String title;
  final String id;
  final double amount;
  final Category values;
  final DateTime date;
  String get formattedDate{
    return formatter.format(date);
  }
}
class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expense});
  ExpenseBucket.forCategory(List<Expenses> allExpenses,this.category)
    : expense = allExpenses
      .where((expense)=> expense.values ==category)
      .toList();
  final Category category;
  final List<Expenses> expense;
  double get totalExpenses{
    double sum =0;
    for(final expense in expense){
      sum+=expense.amount;
    }
    return sum;
  }

}