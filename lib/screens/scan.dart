import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_student_attendance_app/screens/dashboard.dart';
import 'package:qr_code_student_attendance_app/services/database_service.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  ScanResult? scanResult;
  //int? isSuccessful;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');

  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final scanResult = this.scanResult;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.to(() => const Dashboard());
              },
              icon: const Icon(Icons.arrow_back_ios_outlined)),
          title: const Text('S c a n'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.camera),
              tooltip: 'Scan',
              onPressed: _enableContiniousScan,
            )
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            if (scanResult != null)
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Result Type'),
                      subtitle: Text(scanResult.type.toString()),
                    ),
                    ListTile(
                      title: const Text('Raw Content'),
                      subtitle: Text(scanResult.rawContent),
                    ),
                    ListTile(
                      title: const Text('Format'),
                      subtitle: Text(scanResult.format.toString()),
                    ),
                    ListTile(
                      title: const Text('Format note'),
                      subtitle: Text(scanResult.formatNote),
                    ),
                  ],
                ),
              ),
            const ListTile(
              title: Text('Camera selection'),
              dense: true,
              enabled: false,
            ),
            RadioListTile(
              onChanged: (v) => setState(() => _selectedCamera = -1),
              value: -1,
              title: const Text('Default camera'),
              groupValue: _selectedCamera,
            ),
            ...List.generate(
              _numberOfCameras,
              (i) => RadioListTile(
                onChanged: (v) => setState(() => _selectedCamera = i),
                value: i,
                title: Text('Camera ${i + 1}'),
                groupValue: _selectedCamera,
              ),
            ),
            const ListTile(
              title: Text('Button Texts'),
              dense: true,
              enabled: false,
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Flash On',
                ),
                controller: _flashOnController,
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Flash Off',
                ),
                controller: _flashOffController,
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Cancel',
                ),
                controller: _cancelController,
              ),
            ),
            if (Platform.isAndroid) ...[
              const ListTile(
                title: Text('Android specific options'),
                dense: true,
                enabled: false,
              ),
              ListTile(
                title: Text(
                  'Aspect tolerance (${_aspectTolerance.toStringAsFixed(2)})',
                ),
                subtitle: Slider(
                  min: -1,
                  max: 1,
                  value: _aspectTolerance,
                  onChanged: (value) {
                    setState(() {
                      _aspectTolerance = value;
                    });
                  },
                ),
              ),
              CheckboxListTile(
                title: const Text('Use autofocus'),
                value: _useAutoFocus,
                onChanged: (checked) {
                  setState(() {
                    _useAutoFocus = checked!;
                  });
                },
              ),
            ],
            const ListTile(
              title: Text('Other options'),
              dense: true,
              enabled: false,
            ),
            CheckboxListTile(
              title: const Text('Start with flash'),
              value: _autoEnableFlash,
              onChanged: (checked) {
                setState(() {
                  _autoEnableFlash = checked!;
                });
              },
            ),
            const ListTile(
              title: Text('Barcode formats'),
              dense: true,
              enabled: false,
            ),
            ListTile(
              trailing: Checkbox(
                tristate: true,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: selectedFormats.length == _possibleFormats.length
                    ? true
                    : selectedFormats.isEmpty
                        ? false
                        : null,
                onChanged: (checked) {
                  setState(() {
                    selectedFormats = [
                      if (checked ?? false) ..._possibleFormats,
                    ];
                  });
                },
              ),
              dense: true,
              enabled: false,
              title: const Text('Detect barcode formats'),
              subtitle: const Text(
                'If all are unselected, all possible '
                'platform formats will be used',
              ),
            ),
            ..._possibleFormats.map(
              (format) => CheckboxListTile(
                value: selectedFormats.contains(format),
                onChanged: (i) {
                  setState(() => selectedFormats.contains(format)
                      ? selectedFormats.remove(format)
                      : selectedFormats.add(format));
                },
                title: Text(format.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _enableContiniousScan() async {
    int count = 1;
    for (int x = 0; x <= count; x++) {
      await _scan();
    }
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );

      setState(() => scanResult = result);

      int i = await DatabaseService.instance.insert({
        DatabaseService.colIndexNumber:
            jsonDecode(scanResult!.rawContent)['id'],
        DatabaseService.colName: jsonDecode(scanResult!.rawContent)['name'],
        DatabaseService.colClass: jsonDecode(scanResult!.rawContent)['class']
      });
      print('The inserted id is $i');
      //print(jsonDecode(scanResult!.rawContent));
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }
}
