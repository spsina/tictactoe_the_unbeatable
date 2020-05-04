import 'dart:convert';
import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'package:mutex/mutex.dart';

import 'helper.dart';

class WebSocketConnection {
  final String url;
  final int timeout;                     // socket connection timeout in seconds, 15 is default
  WebSocket _socket;                     // the underlying socket connection
  IOWebSocketChannel _channel;           // Channel wrapper
  Set<Function> _subscribers;            // subscribers are functions that will be called on data event
  bool isOn = false;                     // indicates that a live connection is established with the server
  Mutex m = Mutex();

  WebSocketConnection({this.url, this.timeout=15}){
    _subscribers = Set();
    establishConnection();
  }

  void _clearChannel() {
    if (_channel != null) {
      if (_channel.sink != null) {
        _channel.sink.close();
      }
    }

    if (_socket != null) {
      _socket.close();
    }
  }

  Future<void> establishConnection() async {
    // establish a connection with the server
    try {
      _clearChannel();
      _socket = await WebSocket
          .connect(url)
          .timeout(Duration(seconds: timeout));
      _channel = IOWebSocketChannel(_socket);
      _channel.stream.listen(masterListener, onDone: connectionDropped);
      isOn = true;
    } catch(err) {
      toastError("Could not connect to the server");
      isOn = false;
    }
  }

  Future<void> ensureConnection() async {
    // try to establish a connection if no active connections
    if (!isOn){
      await establishConnection();
    }
  }

  void connectionDropped() {

    // notify subscribers
    // each subscriber will receive
    // a message indicating that the connection is dropped

    var droppedMsg = {
      'status': -1,
      'details': "Connection dropped"
    };

    masterListener(jsonEncode(droppedMsg));

    toastError("Your connection was dropped");

    // web socket connection has dropped
    isOn = false;
  }

  Future<void> subscribe(Function func) async {
    await m.acquire();
    try {
      // add function to subscribers set
      _subscribers.add(func);
    } finally {
      m.release();
    }
  }

  Future<void> unsubscribe(Function func) async {
    await m.acquire();
    try {
      // remove function from subscribers list
      _subscribers.removeWhere((sub) => sub == func);
    } finally {
      m.release();
    }
  }

  Future<bool> send(dynamic dictMsg) async{
    // send json encoded dictMsg to the server

    await ensureConnection();

    if (isOn) {
      _channel.sink.add(jsonEncode(dictMsg));
      return true;
    }
    else
      return false;
  }

  Future<void> masterListener(dynamic msg) async{
    // master socket listener
    // all the subscribed functions
    // will be called with a json decoded msg

    var jsonMsg = jsonDecode(msg);

    // during broadcast members cannot change
    await m.acquire();
    try {
      _subscribers.forEach((subscriber) {
        subscriber(jsonMsg);
      });
    } finally {
      m.release();
    }
  }

  void dispose(){
    _clearChannel();
  }
}