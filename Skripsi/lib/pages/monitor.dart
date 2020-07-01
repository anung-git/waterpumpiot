import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_table/json_table.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:Skripsi/preseter/preseter.dart';

import 'package:Skripsi/view/view.dart';
import 'package:Skripsi/model/model.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Monitor extends StatefulWidget {
  final String title;
  final AppPreseter preseter;
  Monitor(this.preseter, {this.title, Key key}) : super(key: key);
  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> implements AppView {
  AppModel _appModel; //import model
  final dbRef = FirebaseDatabase.instance.reference();
  List jsonSample;
  double sumurValue;
  double tankvalue;

  @override
  void initState() {
    super.initState();
    this.widget.preseter.view = this;
    sumurValue = 10;
    tankvalue = 12;
    // _initData();
    // modelListen();
    dbRef.child("Level").onChildChanged.listen(
      (event) {
        modelListen();
      },
    );
  }

  void modelListen() {
    dbRef.child("Level/Tank").once().then(
      (DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        List<dynamic> sorting = values.values.toList()..sort((a, b) => b['Jam'].compareTo(a['Jam']));
        print(sorting);
        String jsonData = "[";
        values.forEach((key, values) {
          jsonData += "{";
          jsonData += '"Tinggi":"' + values["Tinggi"].toString() + '",';
          jsonData += '"Jam":"' + values["Jam"].toString() + '",';
          jsonData += '"Tanggal":"' + values["Tanggal"].toString() + '"';
          jsonData += "},";
          // print("jam"+values["Jam"].toString());
          // print("Tanggal"+ values["Tanggal"].toString());
          // print( "Tinggi" + values["Tinggi"].toString());
        });
        jsonData += "]";
        // print(jsonData);
        final find = ',]';
        final replaceWith = ']';
        final newString = jsonData.replaceAll(find, replaceWith);
        setState(() {
          jsonSample = jsonDecode(newString) as List;
        });
      },
    );
  }

  @override
  void refresData(AppModel model) {
    setState(() {
      this._appModel = model;
    });
  }

  void naik() {
    if (sumurValue > 100) {
      sumurValue = 0;
      tankvalue = 2;
    }
    setState(() {
      sumurValue += 8;
      tankvalue += 7;
    });
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  // void _initData() async {
  //   try {
  //     final jsonString = await rootBundle.loadString('assets/countries.json');
  //     if (mounted)
  //       setState(() {
  //         jsonSample = jsonDecode(jsonString) as List;
  //       });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Sumur",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.blueAccent),
                  ),
                  Text(
                    "Tank",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.blueAccent),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.black54, //beground
                      child: SfRadialGauge(
                        key: null,
                        axes: <RadialAxis>[
                          RadialAxis(
                              radiusFactor: 0.98,
                              startAngle: 140,
                              endAngle: 40,
                              minimum: 0,
                              maximum: 100,
                              showAxisLine: false,
                              majorTickStyle: MajorTickStyle(
                                  length: 0.15,
                                  lengthUnit: GaugeSizeUnit.factor,
                                  thickness: 2),
                              labelOffset: 8,
                              axisLabelStyle: GaugeTextStyle(
                                  fontFamily: 'Times',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic),
                              minorTicksPerInterval: 9,
                              interval: 10,
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                    value: sumurValue,
                                    needleStartWidth: 2,
                                    needleEndWidth: 2,
                                    needleColor: const Color(0xFFF67280),
                                    needleLength: 0.8,
                                    lengthUnit: GaugeSizeUnit.factor,
                                    enableAnimation: true,
                                    animationType: AnimationType.bounceOut,
                                    animationDuration: 1500,
                                    knobStyle: KnobStyle(
                                        knobRadius: 8,
                                        sizeUnit: GaugeSizeUnit.logicalPixel,
                                        color: const Color(0xFFF67280)))
                              ],
                              minorTickStyle: MinorTickStyle(
                                  length: 0.08,
                                  thickness: 1,
                                  lengthUnit: GaugeSizeUnit.factor,
                                  color: const Color(0xFFC4C4C4)),
                              axisLineStyle: AxisLineStyle(
                                  color: const Color(0xFFDADADA),
                                  thicknessUnit: GaugeSizeUnit.factor,
                                  thickness: 0.1)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black54, //beground
                      child: SfRadialGauge(
                        key: null,
                        axes: <RadialAxis>[
                          RadialAxis(
                              radiusFactor: 0.98,
                              startAngle: 140,
                              endAngle: 40,
                              minimum: 0,
                              maximum: 100,
                              showAxisLine: false,
                              majorTickStyle: MajorTickStyle(
                                  length: 0.15,
                                  lengthUnit: GaugeSizeUnit.factor,
                                  thickness: 2),
                              labelOffset: 8,
                              axisLabelStyle: GaugeTextStyle(
                                  fontFamily: 'Times',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic),
                              minorTicksPerInterval: 9,
                              interval: 10,
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                    value: tankvalue,
                                    needleStartWidth: 2,
                                    needleEndWidth: 2,
                                    needleColor: const Color(0xFFF67280),
                                    needleLength: 0.8,
                                    lengthUnit: GaugeSizeUnit.factor,
                                    enableAnimation: true,
                                    animationType: AnimationType.bounceOut,
                                    animationDuration: 1500,
                                    knobStyle: KnobStyle(
                                        knobRadius: 8,
                                        sizeUnit: GaugeSizeUnit.logicalPixel,
                                        color: const Color(0xFFF67280)))
                              ],
                              minorTickStyle: MinorTickStyle(
                                  length: 0.08,
                                  thickness: 1,
                                  lengthUnit: GaugeSizeUnit.factor,
                                  color: const Color(0xFFC4C4C4)),
                              axisLineStyle: AxisLineStyle(
                                  color: const Color(0xFFDADADA),
                                  thicknessUnit: GaugeSizeUnit.factor,
                                  thickness: 0.1)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              jsonSample == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : JsonTable(
                      jsonSample,
                      showColumnToggle: true,
                      allowRowHighlight: true,
                      rowHighlightColor: Colors.green.withOpacity(0.7),
                      paginationRowCount: 40,
                      onRowSelect: (index, map) {
                        print(index);
                        print(map);
                      },
                    ),
              SizedBox(
                height: 40.0,
              ),
              Text("Skripsi Kendali Pompa Air Berbasis IoT")
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.delete),
          onPressed: () {
            this.widget.preseter.buttonClick();
            naik();
            setState(
              () {},
            );
          }),
    );
  }
}
