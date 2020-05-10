import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mutex/mutex.dart';

class Notifier {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();      // main firebase cloud messaging instance
  static final Set<Function> _subscribers = Set();                              // functions that get called when a notification is received
  static bool isInit = false;
  static Random rnd = Random();
  static Mutex m = Mutex();

  static List<dynamic> archive = List();

  Notifier() {
    if (!isInit)
      init();
  }

  static void subscribe(Function f) async{
    await m.acquire();
    _subscribers.add(f);

    archive.forEach((msg) {
      f(msg);
    });

    archive = List();
    m.release();
  }

  static void unsubscribe(Function f) async {
    m.acquire();
    _subscribers.remove(f);
    m.release();
  }

  static void dispatch(dynamic notification) async{
    m.acquire();
    if (!isInit) {
      archive.add(notification);
      return;
    }

    _subscribers.forEach((f) {
      f(notification);
    });

    m.release();

  }

  static Future<dynamic> handler(Map<String, dynamic> msg) async {
    if (msg['data']['dispatch'] == "true")
      Notifier.dispatch(msg);
  }

  static void init() async {
    _firebaseMessaging.configure(
      onMessage: handler,
      onLaunch: handler,
      onResume: handler
    );

    isInit = true;
  }
}

