import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_student_attendance_app/screens/delete_attendee.dart';
import 'package:qr_code_student_attendance_app/screens/info_page.dart';
import 'package:qr_code_student_attendance_app/screens/scan.dart';
import 'package:qr_code_student_attendance_app/screens/sync_data.dart';
import 'package:qr_code_student_attendance_app/services/database_service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<List<Map<String, dynamic>>> _getAttendees;
  @override
  void initState() {
    super.initState();
    _getAttendees =  DatabaseService.instance.queryAll();
  }
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Attendees'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getAttendees,
        builder: (
            BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot,
            ) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: <Widget>[
                    const Icon(Icons.error, size: 50.0, color: Colors.red,),
                    const Text('Oops! an error occurred'),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context, item){
                return ListTile(
                  minLeadingWidth: 1.0,
                  leading: const Icon(Icons.person),
                  title: Text(snapshot.data![item].values.elementAt(1) + '  (' + snapshot.data![item].values.elementAt(4) + ')', style: TextStyle(fontSize: 12.0),),
                  subtitle: Text(snapshot.data![item].values.elementAt(2) + '  (' + snapshot.data![item].values.elementAt(3) + ')' , style: TextStyle(fontSize: 12.0),),
                  trailing: Text(snapshot.data![item].values.elementAt(0).toString()),
                );
              },
                itemCount: snapshot.data!.length,
              );
                //Text(snapshot.data![1].values.toString());
            } else {
              return Center(child: Column(
                children: <Widget>[
                  const Icon(Icons.no_accounts_rounded),
                  const Text('No Attendees'),
                ],
              ));
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ) ,
      drawer: SafeArea(
        child: Drawer(
          width: 200.0,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                //decoration: BoxDecoration(
                    //gradient:
                        //LinearGradient(colors: [Colors.blue, Colors.white])),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.qr_code_scanner_outlined,
                        size: 100.0,
                        color: Colors.white,
                      ),
                      Text('Q u i c k   A t t e n d a n c e', style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ),

               Container(
                 height: 40.0,
                 child: Padding(
                   padding: const EdgeInsets.only(bottom: 15.0),
                   child: InkWell(
                     splashColor: Colors.blue,
                     child: ListTile(
                       horizontalTitleGap: 2.0,
                       title: Text('Scan'),
                       leading: Icon(Icons.qr_code_scanner),
                       onTap: (){Get.to(const Scan());},
                       trailing: Icon(Icons.arrow_right),
                     ),
                   ),
                 ),
               ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
                child: Divider(thickness: 1.0, color: Colors.grey.shade300,),
              ),
              Container(
                height: 40.0,
                child: ListTile(
                  horizontalTitleGap: 2.0,
                  title: Text('Sync'),
                  leading: Icon(Icons.sync_outlined),
                  onTap: (){Get.to(const SyncData());},
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
                child: Divider(thickness: 1.0, color: Colors.grey.shade300,),
              ),
              Container(
                height: 40.0,
                child: ListTile(
                  horizontalTitleGap: 2.0,
                  title: Text('Delete'),
                  leading: Icon(Icons.delete_forever),
                  onTap: (){Get.to(const DeleteAttendee());},
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
                child: Divider(thickness: 1.0, color: Colors.grey.shade300,),
              ),
              Container(
                height: 40.0,
                child: ListTile(
                  horizontalTitleGap: 2.0,
                  title: Text('Info'),
                  leading: Icon(Icons.info_sharp),
                  onTap: (){Get.to(const InfoPage());},
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
                child: Divider(thickness: 1.0, color: Colors.grey.shade300,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
