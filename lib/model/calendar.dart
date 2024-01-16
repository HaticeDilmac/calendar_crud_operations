// Takvim elemanlarını temsil eden sınıf
class CalendarItem {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final List<int> selectedDays;

  CalendarItem({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.selectedDays,
  });
}
