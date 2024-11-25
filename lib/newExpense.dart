import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:expenses_tracker/models/expenses.dart";

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAdd});

  final void Function(Expenses expenses) onAdd;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  DateTime? _realDate;
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedOne = Category.leisure;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final selectedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        initialDate: now,
        lastDate: now);
    setState(() {
      _realDate = selectedDate;
    });
  }

  void _submitResponse() {
    final invalidAmount = double.tryParse(_amountController.text);
    final invalidInput = invalidAmount == null || invalidAmount <= 0 ||
        _realDate == null;
    if (_textController.text
        .trim()
        .isEmpty || invalidInput) {
      showDialog(context: context,
          builder: (ctx) =>
              AlertDialog(
                  title: const Text("Invalid input"),
                  content: const Text("Enter a valid title,amount or date"),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.pop(ctx);
                    }, child: const Text("Okay"))
                  ]
              )


      );
    }
    else {
      widget.onAdd(Expenses(title: _textController.text,
          amount: invalidAmount,
          values: _selectedOne,
          date: _realDate!));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text("Amount"), prefixText: "\$"),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 20),
                    Text(_realDate == null
                        ? "No date chosen"
                        : formatter.format(_realDate!)),
                    IconButton(
                        onPressed: _datePicker,
                        icon: const Icon(Icons.calendar_month_outlined))
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(height: 70),
              DropdownButton(
                  value: _selectedOne,
                  items: Category.values
                      .map((item) =>
                      DropdownMenuItem(
                          value: item, child: Text(item.name.toUpperCase())))
                      .toList(),
                  onChanged: (item) {
                    if (item == null) {
                      return;
                    }
                    setState(() {
                      _selectedOne = item;
                    });
                  }),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: _submitResponse, child: const Text("Save")),
              const SizedBox(width: 50),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
            ],
          )
        ],
      ),
    );
  }
}
