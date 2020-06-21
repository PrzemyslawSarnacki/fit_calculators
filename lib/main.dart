import 'package:fit_calculators/wilks.dart';
import 'package:flutter/material.dart';
import 'bodyfat.dart';
import 'bmi.dart';
import 'wilks.dart';
import 'ipf.dart';

void main() {
  runApp(
    new MaterialApp(
        title: "BFCalc",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: new BMI(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
    
          // '/bmi': (context) => Bmi(),
          // '/home': (context) => Home(),
          '/bmi': (context) => BMI(),
          '/bodyfat': (context) => Bodyfat(),
          '/wilks': (context) => Wilks(),
          '/ipf': (context) => IPF(),
        }),
  );
}
