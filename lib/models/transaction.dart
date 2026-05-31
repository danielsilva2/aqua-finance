import 'package:uuid/uuid.dart';

enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final String category;
  final DateTime date;

  Transaction({
    String? id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  }) : id = id ?? const Uuid().v4();
}
