import 'package:flutter/material.dart';
import 'bfcalc.dart';

void main(){
  runApp(
      new MaterialApp(
        title: "BFCalc",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: new Home(),
        debugShowCheckedModeBanner: false,
      )
  );
}
