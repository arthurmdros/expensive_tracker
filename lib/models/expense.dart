import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat('dd/MM/yyyy');

const uuid = Uuid();

enum Category { comida, viagem, outros, trabalho }

const categoryIcons = {
  Category.comida: Icons.lunch_dining_outlined,
  Category.viagem: Icons.flight_takeoff_outlined,
  Category.outros: Icons.shopping_bag_outlined,
  Category.trabalho: Icons.work_history_outlined,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;  
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}