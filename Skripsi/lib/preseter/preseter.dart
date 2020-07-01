import 'package:Skripsi/model/model.dart';
import 'package:Skripsi/view/view.dart';
import 'mqttHelper.dart';

class AppPreseter {
  Function(String) callback;
  void setCallback(Function(String) f) {}
  set view(AppView value) {}
  void buttonClick() {
    //fungsi ketika tombol di klik
  }
}

class BasicAppPreseter implements AppPreseter {
  NodeMqtt nodeMcu = new NodeMqtt();

  AppModel _model;
  AppView _view;
  BasicAppPreseter() {
    this._model = AppModel();
    nodeMcu.fetchDone.listen((event) {
      // print("ini dr event $event");
      callback(event);
    });
  }

  @override
  set view(AppView value) {
    _view = value;
    this._view.refresData(this._model);
  }

  @override
  void buttonClick() {
    // int in1 = int.parse(this._model.controller1.text);
    // int in2 = int.parse(this._model.controller2.text);
    // this._model.hasil = in1 + in2;
    this._view.refresData(this._model);
  }


  void setCallback(Function(String) f) {
    this.callback = f;
  }

  @override
  Function(String p1) callback;
}
