import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MoneyScreen extends StatefulWidget {
  const MoneyScreen({super.key});

  @override
  State<MoneyScreen> createState() => _MoneyScreenState();
}

class _MoneyScreenState extends State<MoneyScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _transactions = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String _selectedType = 'Given';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _showAddTransactionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Transaction',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
             ],
             decoration: const InputDecoration(labelText: 'Amount'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: const [
                DropdownMenuItem(value: 'Given', child: Text('Given')),
                DropdownMenuItem(value: 'Received', child: Text('Received')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTransaction,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text('Add'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _addTransaction() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());

    if (title.isEmpty || amount == null) return;

    setState(() {
      _transactions.add({
        'title': title,
        'amount': amount,
        'type': _selectedType,
        'date': DateTime.now(),
      });
    });

    _titleController.clear();
    _amountController.clear();
    Navigator.pop(context);
  }

  List<Map<String, dynamic>> _getFilteredTransactions() {
    String selectedTab = _tabController.index == 0
        ? 'All'
        : (_tabController.index == 1 ? 'Given' : 'Received');

    if (selectedTab == 'All') return _transactions;

    return _transactions
        .where((tx) => tx['type'] == selectedTab)
        .toList();
  }

  double _getTotal(String type) {
    return _transactions
        .where((tx) => tx['type'] == type)
        .fold(0.0, (sum, tx) => sum + tx['amount']);
  }

  @override
  Widget build(BuildContext context) {
    final givenTotal = _getTotal('Given');
    final receivedTotal = _getTotal('Received');
    final balance = receivedTotal - givenTotal;
    final filteredTransactions = _getFilteredTransactions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Money 💰'),
        backgroundColor: Colors.teal,
        bottom: TabBar(
          controller: _tabController,
          onTap: (_) => setState(() {}),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Given'),
            Tab(text: 'Received'),
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSummaryItem('Given', givenTotal, Colors.red),
                  _buildSummaryItem('Received', receivedTotal, Colors.green),
                  _buildSummaryItem('Balance', balance,
                      balance >= 0 ? Colors.blue : Colors.red),
                ],
              ),
            ),
          ),
          Expanded(
            child: filteredTransactions.isEmpty
                ? const Center(child: Text('No transactions'))
                : ListView.builder(
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final tx = filteredTransactions[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              tx['type'] == 'Given' ? Colors.red : Colors.green,
                          child: Icon(
                            tx['type'] == 'Given'
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(tx['title']),
                        subtitle: Text(
                          '${tx['type']} • ₹${tx['amount'].toStringAsFixed(2)}',
                        ),
                        trailing: Text(
                          '${tx['date'].day}/${tx['date'].month}/${tx['date'].year}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionSheet,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryItem(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '₹${value.toStringAsFixed(2)}',
          style: TextStyle(color: color, fontSize: 16),
        ),
      ],
    );
  }
}
