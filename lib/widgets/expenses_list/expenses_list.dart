import 'package:expensive_tracker/models/expense.dart';
import 'package:expensive_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expensesList, required this.onRemoveExpense});

  final List<Expense> expensesList;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) => Dismissible(
          direction: DismissDirection.endToStart,
          key: ValueKey(expensesList[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: Theme.of(context).cardTheme.margin,
            child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Remover',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ]),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expensesList[index]);
          },
          child: ExpenseItem(expensesList[index])),
    );
  }
}
