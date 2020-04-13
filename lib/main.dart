import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordpair/toptitle.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // to hide only bottom bar:
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);

  // to hide only status bar: 
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);

  // to hide both:
  SystemChrome.setEnabledSystemUIOverlays ([]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Gearus'),
      title: "App",
      home: Scaffold(
        backgroundColor: Color(0xff1B2429),
        body: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // TIC TAC TOE THE UNBEATABLE
              TopTitle(),

             ],
            ),
          ),
        )
      );
  }

}
