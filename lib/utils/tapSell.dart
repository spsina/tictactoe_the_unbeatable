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

  Future<void> requestAndShow(bool isReward) async {
    if (ready) {
      if (isReward)
        await platform.invokeMethod('requestAndShowReward');
      else
        await platform.invokeMethod('requestAndShowInstant');
    }
  }
}