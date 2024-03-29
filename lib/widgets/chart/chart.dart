import 'package:expensive_tracker/models/expense.dart';
import 'package:expensive_tracker/models/expense_bucket.dart';
import 'package:expensive_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class ChartExpense extends StatelessWidget {
  const ChartExpense({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.comida),
      ExpenseBucket.forCategory(expenses, Category.outros),
      ExpenseBucket.forCategory(expenses, Category.viagem),
      ExpenseBucket.forCategory(expenses, Category.trabalho),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary.withOpacity(0.3),
          Theme.of(context).colorScheme.primary.withOpacity(0.0),
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...buckets.map(
                  (bucket) => ChartBarExpense(
                    fill: bucket.totalExpenses / maxTotalExpense,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: Tooltip(
                        message: Category
                            .values[Category.values.indexOf(bucket.category)]
                            .name
                            .toString()
                            .toUpperCase(),
                        child: Icon(
                          categoryIcons[bucket.category],
                          color: isDarkMode
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
