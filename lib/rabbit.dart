import 'package:flutter/material.dart';
import "package:dart_amqp/dart_amqp.dart";
import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';

final MqttClient client = MqttClient.withPort('wss://mq.inoutdelivery.com.co', 'dev-flutter/demo', 15676);


class rabbitState extends StatefulWidget {
  rabbitView createState() => rabbitView();
}

class rabbitView extends State<rabbitState> {
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    exit(-1);
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  /// Pong callback
  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }
  void _main() async {
    /// A websocket URL must start with ws:// or wss:// or Dart will throw an exception, consult your websocket MQTT broker
    /// for details.
    /// To use websockets add the following lines -:
    client.useWebSocket = true;
    /// client.port = 80;  ( or whatever your WS port is)
    /// There is also an alternate websocket implementation for specialist use, see useAlternateWebSocketImplementation
    /// Note do not set the secure flag if you are using wss, the secure flags is for TCP sockets only.
    /// You can also supply your own websocket protocol list or disable this feature using the websocketProtocols
    /// setter, read the API docs for further details here, the vast majority of brokers will support the client default
    /// list so in most cases you can ignore this.

    /// Set logging on if needed, defaults to off
    client.logging(on: true);

    /// If you intend to use a keep alive value in your connect message that is not the default(60s)
    /// you must set it here
    client.keepAlivePeriod = 30;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    client.onConnected = onConnected;

    /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    /// You can add these before connection or change them dynamically after connection if
    /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
    /// can fail either because you have tried to subscribe to an invalid topic or the broker
    /// rejects the subscribe request.
    client.onSubscribed = onSubscribed;
    client.secure = false;

    /// Set a ping received callback if needed, called whenever a ping response(pong) is received
    /// from the broker.
    client.pongCallback = pong;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password, the default keepalive interval(60s)
    /// and clean session, an example of a specific one below.
    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier('4545')
        .keepAliveFor(20) // Must agree with the keep alive set above or not set
        .withWillTopic('willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however eill
    /// never send malformed messages.
    try {
      await client.connect('tracking', r'Track2$0_19');
      print('status.......: $client.connectionStatus');
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:  Row(
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