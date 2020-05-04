import 'package:firebase_messaging/firebase_messaging.dart';

class Notifier {
  FirebaseMessaging _firebaseMessaging;      // main firebase cloud messaging instance
  Set<Function> _subscribers;                // functions that get called when a notification is received
  bool isInit = false;

  Notifier() {
    _firebaseMessaging = FirebaseMessaging();
    _subscribers = Set();
    init();
  }

  void subscribe(Function f) {
    _subscribers.add(f);
  }

  void unsubscribe(Function f){
    _subscribers.remove(f);
  }

  void dispatch(dynamic notification){
    if (!isInit)
      return;

    _subscribers.forEach((f) {
      f(notification);
    });

  }

  void init() async {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> msg) async {
        if (msg['data']['dispatch'] == "true")
          dispatch(msg);
      },
      onResume: (Map<String, dynamic> msg) async {
        if (msg['data']['dispatch'] == "true")
          dispatch(msg);
      },
      onLaunch: (Map<String, dynamic> msg) async {
        if (msg['data']['dispatch'] == "true")
          dispatch(msg);
      },
    );

    isInit = true;
  }
}