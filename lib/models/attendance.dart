class Attendance {
  Attendance(
      {required this.id,
      required this.name,
      required this.studClass,
      required this.date});

  int id;
  String name;
  String studClass;
  String date;

  Attendance.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        studClass = json['class'],
        date = DateTime.now().toIso8601String();

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'class': studClass, 'date': date};
}
