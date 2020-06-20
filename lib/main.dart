import 'package:flutter/material.dart';
import 'bfcalc.dart';
import 'bmicalc.dart';
import 'bodyfat.dart';
import 'bmi.dart';

void main() {
  runApp(
    new MaterialApp(
        title: "BFCalc",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: new Home(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
    
          '/bmi': (context) => Bmi(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/home': (context) => Home(),
          '/calc': (context) => BMI(),
          '/bodyfat': (context) => Bodyfat(),
        }),
  );
}
