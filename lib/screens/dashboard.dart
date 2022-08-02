import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_student_attendance_app/screens/scan%20info.dart';
import 'package:qr_code_student_attendance_app/screens/scan.dart';
import 'package:qr_code_student_attendance_app/screens/settings.dart';
import 'package:qr_code_student_attendance_app/screens/sync_data.dart';
import 'package:qr_code_student_attendance_app/screens/view_data.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const <Widget>[
            Text('Network Status: '),
            //TODO: Show network status graphically here
            Icon(Icons.wifi_off_rounded),
          ],
        ),
      ),
      drawer: Drawer(
        width: 220.0,
        child: Column(
          children: <Widget>[
            Container(
              height: 200.0,
              color: Colors.lightBlue,
              child: Center(
                child: Column(
                  children: const <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Icon(
                      Icons.qr_code_scanner_outlined,
                      color: Colors.white,
                      size: 150.0,
                    ),
                    Text(
                      'Q u i c k      A t t e n d a n c e',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Get.to(const Scan());
                    },
                    child: buildListTile(
                      leading: const Icon(Icons.qr_code_scanner_outlined),
                      title: const Text('S c a n'),
                    ),
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const ScanInfo());
                    },
                    child: buildListTile(
                      leading: const Icon(Icons.qr_code),
                      title: const Text('QR Code info'),
                    ),
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const SyncData());
                    },
                    child: buildListTile(
                      leading: const Icon(Icons.sync_outlined),
                      title: const Text('S y n c   D a t a'),
                    ),
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const ViewData());
                    },
                    child: buildListTile(
                      leading: const Icon(Icons.insert_drive_file_outlined),
                      title: const Text('V i e w   D a t a'),
                    ),
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const Settings());
                    },
                    child: buildListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('S e t t i n g s'),
                    ),
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListTile({required Widget leading, required Widget title}) {
    return ListTile(
      leading: leading,
      title: title,
    );
  }
}
