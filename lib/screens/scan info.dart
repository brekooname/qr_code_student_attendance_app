import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanInfo extends StatelessWidget {
  const ScanInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        title: const Text('S C A N   I N F O'),
      ),
    );
  }
}
