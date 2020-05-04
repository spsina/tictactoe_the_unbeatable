import 'package:flutter/services.dart';

class Tapsell {
  MethodChannel platform;
  bool ready = false;

  Tapsell() {
    init();
  }

  Future<void> init() async {
    platform = MethodChannel('ir.l37.tictactoe/tapsell');
    ready = true;
  }

  void requestAndShow() {
    if (ready)
      platform.invokeMethod('requestAndShow');
    else
      print("tapsell not ready");
  }
}