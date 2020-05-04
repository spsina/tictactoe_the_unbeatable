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

  void requestAndShow(bool isReward) {
    if (ready) {
      if (isReward)
        platform.invokeMethod('requestAndShowReward');
      else
        platform.invokeMethod('requestAndShowInstant');
    }
    else
      print("tapsell not ready");
  }
}