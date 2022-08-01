import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: const <Widget>[
          Text('Network Status: '),
          //TODO: Show network status graphically here
          Icon(Icons.wifi_off_rounded),
        ],),
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
                  buildListTile(
                    leading: const Icon(Icons.qr_code_scanner_outlined),
                    title: const Text('S c a n'),
                  ),
                  const Divider(thickness: 1.0,),
                  buildListTile(
                    leading: const Icon(Icons.qr_code),
                    title: const Text('QR Code info'),
                  ),
                  const Divider(thickness: 1.0,),
                  buildListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('S e t t i n g s'),
                  ),
                  const Divider(thickness: 1.0,),
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

  void onScanTap() {}
}
