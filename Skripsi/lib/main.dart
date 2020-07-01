import 'pages/custom_data_table.dart';
import 'pages/monitor.dart';
import 'package:flutter/material.dart';
import 'pages/alarm.dart';
import 'pages/motor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'mqtt/local_notications_helper.dart';

import 'package:Skripsi/model/model.dart';
import 'package:Skripsi/view/view.dart';
import 'package:Skripsi/preseter/preseter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BasicAppPreseter preseter = new BasicAppPreseter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json Table Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.yellow,
      // ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => RootPage(preseter),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/customData': (context) => CustomDataTable(preseter),
        '/alarm': (context) => Monitor(preseter),
      },
    );
  }
}

class RootPage extends StatefulWidget {
  final String title;
  final AppPreseter preseter;
  RootPage(this.preseter, {this.title, Key key}) : super(key: key);
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> implements AppView {
  final notifications = FlutterLocalNotificationsPlugin(); //notifikasi
  int counter =0;
  @override
  void initState() {
    super.initState();
    // _subject.add(_controller.text);
    // _controller.addListener(() {
    //   _subject.add(_controller.text);
    // });=
    ///ori
    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);

    this.widget.preseter.view = this;
    this.widget.preseter.setCallback((a) {
      counter++;
      print("from calback $a");
      showOngoingNotification(FlutterLocalNotificationsPlugin(),
          title: 'guang', body: "ini pesan ke $counter ", id: 2);
    });
  }

  Future onSelectNotification(String payload) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Alarm(this.widget.preseter)),
    );
    notifications.cancelAll();
  }

  // Future onSelectNotification(String payload) {
  //  async => await Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
  //     );
  //   print(payload);
  // }

  // showOngoingNotification(FlutterLocalNotificationsPlugin(),
  //             title: 'Motor', body: "_appModel.alarmMasage", id: 1);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kendali Pompa Air"),
          actions: [
            FlatButton(
              child: Text(
                "Connect",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/customData');
              },
            )
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Motor",
              ),
              // Tab(
              //   text: "Custom Table",
              // ),
              Tab(
                text: "Alarm",
              ),
              Tab(
                text: "Monitor",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Motor(this.widget.preseter),
            Alarm(this.widget.preseter),
            Monitor(this.widget.preseter),
            // CustomColumnNestedTable(),
          ],
        ),
      ),
    );
  }

  @override
  void refresData(AppModel model) {}
}

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

// class RootPage extends StatelessWidget {

//  void subscribe(String msg) {
//     // showOngoingNotification(FlutterLocalNotificationsPlugin(),
//     //     title: 'guang', body: msg, id: 2);
//     // print("ini dari callback ");
//     // print(msg);
//     // modelVariable.nama=msg;
//   }
