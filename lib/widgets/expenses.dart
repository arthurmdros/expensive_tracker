import 'package:expensive_tracker/models/expense.dart';
import 'package:expensive_tracker/widgets/chart/chart.dart';
import 'package:expensive_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expensive_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key, required this.changeTheme});

  final void Function(ThemeMode themeMode) changeTheme;

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  var iconMode = Icons.light_mode_outlined;
  dynamic colorIconMode = Colors.yellow;

  final List<Expense> _registeredExpenses = [];

  void _openAddDialog() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true, //usa toda a altura disponivel no dispositivo
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: _addExpense);
        });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });

    showMessage(
      2,
      Colors.green,
      'Despesa adicionada com sucesso!',
      'X',
      () => null,
    );
  }

  void _delExpense(Expense expense) {
    var index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    showMessage(
      3,
      Colors.green,
      'Despesa removida com sucesso!',
      'Desfazer',
      () {
        setState(() {
          _registeredExpenses.insert(index, expense);
        });
      },
    );
  }

  void showMessage(
    int duration,
    Color panelClass,
    String contentMsg,
    String actionMsg,
    Function() action,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        backgroundColor: panelClass,
        content: Text(
          contentMsg,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        action: SnackBarAction(
          label: actionMsg,
          onPressed: action,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Widget mainContent = const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Nenhuma despesa registrada!'),
        SizedBox(
          height: 50,
        )
      ],
    );

    Widget chartContent = const Center(
      child: Text(''),
    );

    if (_registeredExpenses.isNotEmpty) {
      chartContent = ChartExpense(
        expenses: _registeredExpenses,
      );
      mainContent = ExpensesList(
        expensesList: _registeredExpenses,
        onRemoveExpense: _delExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Despesas',
        ),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (isDarkMode) {
                  iconMode = Icons.dark_mode_outlined;
                  colorIconMode = Colors.white;
                  widget.changeTheme(ThemeMode.light);
                } else {
                  iconMode = Icons.light_mode_outlined;
                  colorIconMode = Colors.yellow;
                  widget.changeTheme(ThemeMode.dark);
                }
              });
            },
            icon: Icon(
              iconMode,
              color: colorIconMode,
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: _openAddDialog,
            icon: const Icon(Icons.add_outlined),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                chartContent,
                Expanded(
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                chartContent,
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
