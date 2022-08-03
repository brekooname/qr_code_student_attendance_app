class Attendance {
  const Attendance(
      {required this.id,
      required this.indexNumber,
      required this.name,
      required this.classIn,
      required this.dateTime});

  final String id;
  final String indexNumber;
  final String name;
  final String classIn;
  final String dateTime;

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
        id: json['id'],
        indexNumber: json['indexNumber'],
        name: json['name'],
        classIn: json['class'],
        dateTime: json['date']);
  }
}
