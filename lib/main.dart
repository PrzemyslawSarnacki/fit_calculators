import 'package:fit_calculators/wilks.dart';
import 'package:flutter/material.dart';
import 'custom_drawer.dart';
import 'bodyfat.dart';
import 'bmi.dart';
import 'wilks.dart';
import 'ipf.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "BFCalc",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: CustomDrawer(child: BMI()),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // '/bmi': (context) => Bmi(),
          // '/home': (context) => Home(),
          '/bmi': (context) => CustomDrawer(child: BMI()),
          '/bodyfat': (context) => CustomDrawer(child: Bodyfat()),
          '/wilks': (context) => CustomDrawer(child: Wilks()),
          '/ipf': (context) => CustomDrawer(child: IPF()),
        });
  }
}
