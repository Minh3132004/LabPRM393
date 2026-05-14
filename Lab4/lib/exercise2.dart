import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // States for input widgets
  double _sliderValue = 20.0;
  bool _switchValue = true;
  int? _radioValue = 1;
  DateTime _selectedDate = DateTime.now();

  // Function to show Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2: Input Widgets')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. Slider
            ListTile(
              title: const Text('Slider Control'),
              subtitle: Text('Value: ${_sliderValue.toInt()}'),
            ),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 10,
              label: _sliderValue.round().toString(),
              onChanged: (value) {
                setState(() => _sliderValue = value);
              },
            ),
            const Divider(),

            // 2. Switch
            SwitchListTile(
              title: const Text('Allow Notifications'),
              value: _switchValue,
              onChanged: (value) {
                setState(() => _switchValue = value);
              },
            ),
            const Divider(),

            // 3. RadioListTile group
            const Text('Select Your Level:', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<int>(
              title: const Text('Beginner'),
              value: 1,
              groupValue: _radioValue,
              onChanged: (val) => setState(() => _radioValue = val),
            ),
            RadioListTile<int>(
              title: const Text('Advanced'),
              value: 2,
              groupValue: _radioValue,
              onChanged: (val) => setState(() => _radioValue = val),
            ),
            const Divider(),

            // 4. DatePicker Button
            ElevatedButton.icon(
              onPressed: () => _selectDate(context),
              icon: const Icon(Icons.calendar_today),
              label: Text('Selected Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
            ),
            
            const Spacer(),
            const Text(
              'Summary of Selections:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Slider: ${_sliderValue.toInt()} | Switch: $_switchValue | Radio: $_radioValue'),
          ],
        ),
      ),
    );
  }
}
