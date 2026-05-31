import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';

class TransactionNotifier extends Notifier<List<Transaction>> {
  @override
  List<Transaction> build() {
    return [];
  }

  void addTransaction(Transaction transaction) {
    state = [...state, transaction];
  }

  double getBalance() {
    return state.fold(0.0, (sum, t) => sum + (t.type == TransactionType.income ? t.amount : -t.amount));
  }
}

final transactionProvider = NotifierProvider<TransactionNotifier, List<Transaction>>(() => TransactionNotifier());
