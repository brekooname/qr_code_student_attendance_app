import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qr_code_student_attendance_app/models/attendance.dart';
import 'package:qr_code_student_attendance_app/screens/splash.dart';
import 'package:qr_code_student_attendance_app/services/googlesheets_sync_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SyncService.init();
  await Hive.initFlutter();
  Hive.registerAdapter(AttendanceAdapter());
  await Hive.openBox('User');
  runApp(
    const GetMaterialApp(
      home: Splash(),
    ),
  );
}
