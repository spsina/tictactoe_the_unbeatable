import 'package:flutter/material.dart';

/* Styles for title and body of show dialog */

// White Style
TextStyle whiteTitleStyle(BuildContext context){
  double tileSize = MediaQuery.of(context).size.width / 9;
  return TextStyle(
    color: Colors.white,
    fontFamily: "",
    fontWeight: FontWeight.bold,
    fontSize: tileSize*0.45,
  );
}

TextStyle whiteBodyStyle(BuildContext context){
  double tileSize = MediaQuery.of(context).size.width / 9;
  return TextStyle(
    color: Colors.white,
    fontFamily: "",
    fontWeight: FontWeight.normal,
    fontSize: tileSize*0.35,
  );
}

// Black Style
TextStyle blackTitleStyle(BuildContext context){
  double tileSize = MediaQuery.of(context).size.width / 9;
  return TextStyle(
    color: Colors.black,
    fontFamily: "",
    fontWeight: FontWeight.bold,
    fontSize: tileSize*0.45,
  );
}

TextStyle blackBodyStyle(BuildContext context){
  double tileSize = MediaQuery.of(context).size.width / 9;
  return TextStyle(
    color: Colors.black,
    fontFamily: "",
    fontWeight: FontWeight.normal,
    fontSize: tileSize*0.35,
  );
}