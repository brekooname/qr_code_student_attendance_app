import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_student_attendance_app/screens/splash.dart';
import 'package:qr_code_student_attendance_app/services/googlesheets_sync_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SyncService.init();
  runApp(
    const GetMaterialApp(
      home: Splash(),
    ),
  );
}
