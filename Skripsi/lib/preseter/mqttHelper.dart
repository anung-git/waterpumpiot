import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class NodeMqtt {
  Map objects;
  StreamController fetchDoneController = new StreamController.broadcast();

  // define constructor here

  // fetch() {
  //   // fetch json from server and then load it to objects
  //   // emits an event here
  //   fetchDoneController.add("all done"); // send an arbitrary event
  // }

  Stream get fetchDone => fetchDoneController.stream;

  static int msgId;
  final client = MqttServerClient('broker.mqtt-dashboard.com', '');

  NodeMqtt() {
    this.connect();
  }
  Future<int> connect() async {
    client.logging(on: false);
    client.keepAlivePeriod = 50;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueIdanung')
        .keepAliveFor(50) // Must agree with the keep alive set above or not set
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    // print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;
    try {
      await client.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    /// Mulai subscription
    const topic = 'anung'; // Not a wildcard topic
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      //call back di sisni pada variable pt
      fetchDoneController.add(pt);
      // event(pt);
      // print('EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      // print('');
    });

    /// If needed you can listen for published messages that have completed the publishing
    /// handshake which is Qos dependant. Any message received on this stream has completed its
    /// publishing handshake with the broker.
    client.published.listen((MqttPublishMessage message) {
      // print('EXAMPLE::Published notification:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
    });

    /// Lets publish to our topic
    /// Use the payload builder rather than a raw buffer
    /// Our known topic to publish to
    const pubTopic = 'anung';
    final builder = MqttClientPayloadBuilder();
    builder.addString('Hello from mqtt_client');

    /// Subscribe to it
    // print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
    // client.subscribe(pubTopic, MqttQos.exactlyOnce);

    /// Publish it
    print('EXAMPLE::Publishing our topic');
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);

    /// Ok, we will now sleep a while, in this gap you will see ping request/response
    /// messages being exchanged by the keep alive mechanism.
    // print('EXAMPLE::Sleeping....');
    // await MqttUtilities.asyncSleep(120);

    /// Finally, unsubscribe and exit gracefully
    // print('EXAMPLE::Unsubscribing');
    // client.unsubscribe(topic);

    /// Wait for the unsubscribe message from the broker if you wish.
    // await MqttUtilities.asyncSleep(2);
    // print('EXAMPLE::Disconnecting');
    return 0;
  }

  //method
  bool status() {
    //cek status konectivitas mqtt
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      return true;
    } else {
      return false;
    }
  }

  void disconnect() {
    client.disconnect();
  }

  void onLed() {
    const pubTopic = 'cinung';
    final builder = MqttClientPayloadBuilder();
    builder.addString('1');
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);
  }

  void offLed() {
    const pubTopic = 'cinung';
    final builder = MqttClientPayloadBuilder();
    builder.addString('0');
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);
  }

  void publishMqtt(String topic, String massage) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(massage);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload);
  }

  void onSubscribed(String topic) {
    // print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    // print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    // if (client.connectionStatus.disconnectionOrigin ==
    //     MqttDisconnectionOrigin.solicited) {
    //   print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    // }
    // exit(-1);
    this.connect();
  }

  /// The successful connect callback
  void onConnected() {
    // print( 'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  /// Pong callback
  void pong() {
    // print('EXAMPLE::Ping response client callback invoked');
  }
}
