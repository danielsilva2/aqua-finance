import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  TransactionType _type = TransactionType.expense;
  String _category = 'Alimentação';

  final categories = ['Alimentação', 'Transporte', 'Salário', 'Lazer', 'Casa', 'Outros'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Transação')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SegmentedButton<TransactionType>(
              segments: const [
                ButtonSegment(value: TransactionType.expense, label: Text('Despesa')),
                ButtonSegment(value: TransactionType.income, label: Text('Receita')),
              ],
              selected: {_type},
              onSelectionChanged: (set) => setState(() => _type = set.first),
            ),
            const SizedBox(height: 20),
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Descrição')),
            TextField(controller: _amountController, decoration: const InputDecoration(labelText: 'Valor'), keyboardType: TextInputType.number),
            DropdownButton<String>(
              value: _category,
              items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_amountController.text) ?? 0;
                final transaction = Transaction(
                  title: _titleController.text,
                  amount: amount,
                  type: _type,
                  category: _category,
                  date: DateTime.now(),
                );
                ref.read(transactionProvider.notifier).addTransaction(transaction);
                Navigator.pop(context);
              },
              child: const Text('Salvar Transação'),
            ),
          ],
        ),
      ),
    );
  }
}
