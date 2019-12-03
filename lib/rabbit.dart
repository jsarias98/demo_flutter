import 'package:flutter/material.dart';
import "package:dart_amqp/dart_amqp.dart";
import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'dart:math';

String broker = 'wss://mq.inoutdelivery.com.co:15676/ws';
final MqttClient client = MqttClient(broker, '');

class rabbitState extends StatefulWidget {
  rabbitView createState() => rabbitView();
}

class rabbitView extends State<rabbitState> {
  String username = 'inout';
  String password = 'inout';
  String clientId = 'connection_flutter_app';
  String topic = 'demo/app/flutter';

  void _main() async {
    client.useWebSocket = true;
    client.port = 15676;
    client.logging(on: false);
    client.keepAlivePeriod = 20;

    client.onDisconnected = () => print("CLiente desconectado");

    client.onConnected = () => print("Cliente conectado");

    client.onSubscribed = (event) => print("Cliente susbcrito");

    client.pongCallback = () => print("CLiente Pong");


    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .keepAliveFor(20)
        .withWillTopic(topic)
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect(username, password);
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client
              .connectionStatus}');
      client.disconnect();
    }

    print('EXAMPLE::Subscribing to the ${ this.topic } topic');
    client.subscribe(topic, MqttQos.atMostOnce);

    this.topic = "new/topic/flutter";

    print('EXAMPLE::Subscribing to the ${ this.topic } topic');
    client.subscribe(topic, MqttQos.atMostOnce);


    /*client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final String pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      /// The above may seem a little convoluted for users only interested in the
      /// payload, some users however may be interested in the received publish message,
      /// lets not constrain ourselves yet until the package has been in the wild
      /// for a while.
      /// The payload is a byte buffer, this will be specific to the topic
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });

    client.published.listen((MqttPublishMessage message) {
      print(
          'EXAMPLE::Published notification:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
    });

    String pubTopic = this.topic;
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString('Hello from mqtt_client');

    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);
    */

  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            child: Text("rabbit"),
            onPressed: () {
              _main();
            },
            color: Colors.green,
            textColor: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            splashColor: Colors.lightGreen,
          )
        ],
      ),
    );
  }
}
