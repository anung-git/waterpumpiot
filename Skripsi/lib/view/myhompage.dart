// import 'package:flutter/material.dart';
// import 'package:flutter_mvp/model/model.dart';
// import 'package:flutter_mvp/preseter/preseter.dart';
// import 'package:flutter_mvp/view/view.dart';

// class MyHomePage extends StatefulWidget {
//   final String title;
//   final AppPreseter preseter;
//   MyHomePage(this.preseter, {this.title, Key key}) : super(key: key);

//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> implements AppView {
//   AppModel _appModel; //import model

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title)),
//       body: Container(
//         margin: EdgeInsets.all(15.0),
//         child: Column(
//           children: <Widget>[
//             Container(height: 15.0),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Masukan angka !",
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//               controller: _appModel.controller1,
//             ),
//             Container(height: 15.0),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Masukan angka !",
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//               controller: _appModel.controller2,
//             ),
//             Container(height: 15.0),
//             Text(
//               "Hasil : ${_appModel.hasil}",
//               style: TextStyle(fontSize: 30.0),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => this.widget.preseter.buttonClick(),
//         child: Icon(
//           Icons.add,
//         ),
//       ),
//     );
//   }

//   @override
//   void refresData(AppModel model) {
//     setState(() {
//       this._appModel = model;
//     });
//     print("direfres");
//   }

//   @override
//   void initState() {
//     //
//     super.initState();
//     this.widget.preseter.view = this;
//   }
// }
