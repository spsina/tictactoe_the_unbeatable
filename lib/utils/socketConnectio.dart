import 'dart:convert';
import 'dart:io';
import 'package:tictactoe/pages/generic/helper.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketConnection {
  final String url;
  final int timeout;                     // socket connection timeout in seconds, 15 is default
  WebSocket _socket;                     // the underlying socket connection
  IOWebSocketChannel _channel;           // Channel wrapper
  Set<Function> _subscribers;            // subscribers are functions that will be called on data event
  bool isOn = false;                     // indicates that a live connection is established with the server

  WebSocketConnection({this.url, this.timeout=15}){
    _subscribers = Set();
    establishConnection();
  }

  Future<void> establishConnection() async {
    // establish a connection with the server
    try {
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
      _socket.close();
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

    // web socket connection has dropped
    isOn = false;
  }

  void subscribe(Function func) {
    // add function to subscribers set
    _subscribers.add(func);
  }

  void unsubscribe(Function func) {
    // remove function from subscribers list
    _subscribers.remove(func);
  }

  Future<bool> send(dynamic dictMsg) async{
    // send json encoded dictMsg to the server

    await ensureConnection();

    if (isOn) {
      _channel.sink.add(jsonEncode(dictMsg));
      return true;
    }
    else {
      toastError("No active connection to the server");
      return false;
    }
  }

  void masterListener(dynamic msg) {
    // master socket listener
    // all the subscribed functions
    // will be called with a json decoded msg

    var jsonMsg = jsonDecode(msg);

    _subscribers.forEach((subscriber) {
      subscriber(jsonMsg);
    });
  }

  void dispose(){
    _socket.close();
  }
}