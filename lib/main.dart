// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/calendar_picker.dart';

import 'model/calendar.dart';

// CalendarListPage widget'ı
class CalendarListPage extends StatefulWidget {
  const CalendarListPage({super.key});

  @override
  _CalendarListPageState createState() => _CalendarListPageState();
}

class _CalendarListPageState extends State<CalendarListPage> {
  List<CalendarItem> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar List'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 231, 231),
                borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              title: Text(items[index].name),
              subtitle: Text(
                  'Start: ${items[index].startDate}, End: ${items[index].endDate}, Days: ${items[index].selectedDays}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarPicker(
                      onSave: (name, startDate, endDate, selectedDays) {
                        setState(() {
                          //modelden çekilen değerler items listesine atama yapılıyor ve veriler buradan okunuyor
                          items[index] = CalendarItem(
                            name: name,
                            startDate: startDate,
                            endDate: endDate,
                            selectedDays: selectedDays,
                          );
                        });
                      }, //bu değerleri de yanbi okunan değerleri bir sonraki sayfaya iletiyoruz.
                      initialName: items[index].name,
                      initialStartDate: items[index].startDate,
                      initialEndDate: items[index].endDate,
                      initialSelectedDays: items[index].selectedDays,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni bir takvim eklemek için FloatingActionButton'a tıklandığında çalışan fonksiyon
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CalendarPicker(
                // CalendarPicker widget'ında yapılan seçimleri alan fonksiyon
                onSave: (name, startDate, endDate, selectedDays) {
                  setState(() {
                    // Yeni bir CalendarItem ekleyerek items listesini güncelliyoruz
                    items.add(CalendarItem(
                      name: name,
                      startDate: startDate,
                      endDate: endDate,
                      selectedDays: selectedDays,
                    ));
                  });
                },
                // İlk başta boş bir isimle, bugünün tarihi ile başlangıç tarihi,
                // 1 hafta sonrası ile bitiş tarihi ve boş günlerle başlatılan CalendarPicker
                initialName: '',
                initialStartDate: DateTime.now(),
                initialEndDate: DateTime.now().add(const Duration(days: 7)),
                initialSelectedDays: [],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CalendarListPage(),
  ));
}
