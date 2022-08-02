import 'package:hive/hive.dart';

part 'attendance.g.dart';

@HiveType(typeId: 0)
class Attendance extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String studClass;
  @HiveField(3)
  late DateTime scannedDate;
}
