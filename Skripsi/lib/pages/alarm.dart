import 'package:flutter/material.dart';
import 'package:Skripsi/preseter/preseter.dart';
import 'package:Skripsi/model/model.dart';
import 'package:Skripsi/view/view.dart';

class Alarm extends StatefulWidget {
  final String title;
  final AppPreseter preseter;
  Alarm(this.preseter, {this.title, Key key}) : super(key: key);
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> implements AppView {
  AppModel _appModel; //import model

  @override
  void initState() {
    super.initState();

    this.widget.preseter.view = this;
    //     this.widget.preseter.callback(a){
    //   print(a);
    // };
  }
     _getSizes() {}

  _getPositions() {}
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     padding: EdgeInsets.all(16.0),
    //     child: Column(
    //       children: <Widget>[
    //         SizedBox(
    //           height: 16.0,
    //         ),
    //         Text(
    //           "anung",
    //           style: TextStyle(fontSize: 13.0),
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton:
    //       FloatingActionButton(child: Icon(Icons.play_arrow), onPressed: () {}),
    // );



  // @override
  // Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(left: 0.0, bottom: 8.0, right: 16.0),
      decoration: new BoxDecoration(color: Colors.blue),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '0.00',
            style: TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'Current Balance',
            style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold),
          ),
          new Card(
            child: new Column(
              children: <Widget>[
                new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Icon(Icons.thumb_up),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Text(
                            'Like',
                            style: new TextStyle(fontSize: 18.0),
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Icon(Icons.comment),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Text('Comments', style: new TextStyle(fontSize: 18.0)),
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
  // }

  @override
  void refresData(AppModel model) {}
}
