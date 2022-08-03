import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_student_attendance_app/screens/splash.dart';
import 'package:qr_code_student_attendance_app/services/googlesheets_sync_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  try{
    await SyncService.init();
    print('Sheet successfully initialized');
  }catch(e){
    print('Error connection to google sheets');
  }
  // await Hive.initFlutter();
  // Hive.registerAdapter(AttendanceAdapter());
  // await Hive.openBox('User');
  runApp(
    const GetMaterialApp(
      home: Splash(),
    ),
  );
}
