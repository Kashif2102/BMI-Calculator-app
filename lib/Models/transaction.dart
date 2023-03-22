import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final double BMI;
  final double height;
  final double weight;
  final DateTime date;

  Transaction({
    required this.id,
    required this.BMI,
    required this.height,
    required this.weight,
    required this.date,
  });
}
