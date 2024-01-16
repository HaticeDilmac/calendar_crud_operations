// CalendarPicker widget'ı
import 'package:flutter/material.dart';

class CalendarPicker extends StatefulWidget {
  final Function(String, DateTime, DateTime, List<int>) onSave;
  final String initialName;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final List<int> initialSelectedDays;

  CalendarPicker({
    required this.onSave,
    this.initialName = '',
    required this.initialStartDate,
    required this.initialEndDate,
    required this.initialSelectedDays,
  });

  @override
  _CalendarPickerState createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  late TextEditingController _nameController;
  late DateTime _startDate;
  late DateTime _endDate;
  late List<bool> _selectedDays;

  @override
  void initState() {
    super.initState(); //güncelleme için doldurulur
    _nameController = TextEditingController(text: widget.initialName);
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
    _selectedDays = List.generate(7, (index) {
      return widget.initialSelectedDays.contains(index);
    });
  }

  // Tarih seçim ekranını açan metod
  Future<void> _selectDate(bool isStartDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
        } else {
          _endDate = selectedDate;
        }
      });
    }
  }

  // Gün seçimini tersine çeviren metod
  void _toggleDay(int index) {
    setState(() {
      _selectedDays[index] = !_selectedDays[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Picker'),
        actions: [
          IconButton(
            onPressed: () {
              widget.onSave(
                _nameController.text,
                _startDate,
                _endDate,
                _selectedDays
                    .asMap()
                    .entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList(),
              );
              Navigator.pop(context);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Calendar Name'),
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text('Start Date'),
              subtitle: Text('${_startDate.toLocal()}'.split(' ')[0]),
              onTap: () => _selectDate(true),
            ),
            ListTile(
              title: Text('End Date'),
              subtitle: Text('${_endDate.toLocal()}'.split(' ')[0]),
              onTap: () => _selectDate(false),
            ),
            SizedBox(height: 16.0),
            Text('Select Days:'),
            Wrap(
              children: List.generate(7, (index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FilterChip(
                    labelPadding: EdgeInsets.all(2),
                    label: Text([
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat',
                      'Sun'
                    ][index]),
                    selected: _selectedDays[index],
                    onSelected: (_) => _toggleDay(index),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
