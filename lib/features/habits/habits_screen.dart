import 'package:flutter/material.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  final List<Map<String, dynamic>> _habits = [];

  final _habitNameController = TextEditingController();
  String _selectedFrequency = 'Daily';

  final List<String> _frequencies = ['Daily', 'Weekly', 'Monthly'];

  void _addHabit() {
    final name = _habitNameController.text.trim();
    if (name.isEmpty) return;

    setState(() {
      _habits.add({
        'name': name,
        'frequency': _selectedFrequency,
        'done': false,
      });
    });
    _habitNameController.clear();
    _selectedFrequency = 'Daily';
    Navigator.of(context).pop();
  }

  void _showAddHabitDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add New Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _habitNameController,
                decoration: const InputDecoration(labelText: 'Habit Name'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedFrequency,
                items: _frequencies
                    .map((freq) => DropdownMenuItem(
                          value: freq,
                          child: Text(freq),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedFrequency = val;
                    });
                  }
                },
                decoration: const InputDecoration(labelText: 'Frequency'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _habitNameController.clear();
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addHabit,
              child: const Text('Add'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        );
      },
    );
  }

  void _toggleDone(int index) {
    setState(() {
      _habits[index]['done'] = !_habits[index]['done'];
    });
  }

  @override
  void dispose() {
    _habitNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: _showAddHabitDialog,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _habits.isEmpty
          ? const Center(
              child: Text(
                'No habits added yet.\nTap + to add a habit.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: _habits.length,
              itemBuilder: (ctx, i) {
                final habit = _habits[i];
                return ListTile(
                  title: Text(habit['name']),
                  subtitle: Text('Frequency: ${habit['frequency']}'),
                  trailing: Checkbox(
                    value: habit['done'],
                    onChanged: (_) => _toggleDone(i),
                    activeColor: Colors.teal,
                  ),
                );
              },
            ),
    );
  }
}
