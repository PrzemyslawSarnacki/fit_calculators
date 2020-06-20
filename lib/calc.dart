import 'dart:js';
import 'dart:js_util';
import 'package:flutter/material.dart';
import 'dart:math';
import 'bmicalc.dart';
import 'bfcalc.dart';
import 'custom_drawer.dart';

import 'package:flutter/cupertino.dart';
import 'package:vibration/vibration.dart';

void main() => runApp(MaterialApp(
      home: Calc(),
    ));

class Calc extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Calc> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  double _result = 0.0;
  String _finalResultPrint;
  double _weightController = 60;
  double _heightController = 175;
  bool _visibility = false;

  void _bfValue() {
    setState(() {
      double weight = _weightController;
      double height = _heightController;

      if (((height > 0) && (weight > 0))) {
        _result = weight / (height * height / 100 / 100);
        _result = double.parse(_result.toStringAsFixed(2));
      } else {
        print("Error");
      }

      if ((double.parse(_result.toStringAsFixed(1)) < 18.5)) {
        _finalResultPrint = "UnderWeight";
      } else if (double.parse(_result.toStringAsFixed(1)) > 18.5 &&
          (double.parse(_result.toStringAsFixed(1)) <= 25.0)) {
        _finalResultPrint = "Normal";
      } else if ((double.parse(_result.toStringAsFixed(1)) > 25.0) &&
          (double.parse(_result.toStringAsFixed(1))) < 30.0) {
        _finalResultPrint = "OverWeight";
      } else if ((double.parse(_result.toStringAsFixed(1))) >= 30.0) {
        _finalResultPrint = "Obesity";
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        child: Calc(),
      ),
      resizeToAvoidBottomPadding: false,
      body: CustomPaint(
        painter: BluePainter(),
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(25, 70, 25, 0),
            child: Column(
              children: <Widget>[
                Container(
                  transform: Matrix4.translationValues(-150, -10, 0.0),
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                Text(
                  'Calculated BMI Value',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Titillium',
                  ),
                ),
                Text(
                  '${_result == null ? "---" : "$_result"}',
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.white,
                    fontFamily: 'Titillium',
                  ),
                ),
                Text(
                  '${_finalResultPrint == null ? "---" : "$_finalResultPrint"}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'Titillium',
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(22, 9, 22, 9),
                    color: Color.fromRGBO(65, 200, 235, 1),
                    onPressed: () {
                      _bfValue();
                    },
                    child: Text(
                      'Calculate',
                      style: TextStyle(
                        color: Color.fromRGBO(214, 243, 250, 1),
                        fontSize: 17,
                        fontFamily: 'Titillium',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                _buildCustomSlider(
                  "Weight",
                  _weightController,
                  "kg",
                  30,
                  230,
                  Slider(
                    inactiveColor: Color.fromRGBO(231, 237, 245, 1),
                    activeColor: Color.fromRGBO(49, 152, 213, 1),
                    min: 30,
                    max: 230,
                    onChanged: (newValue) {
                      setState(() {
                        _weightController =
                            double.parse(newValue.toStringAsFixed(2));
                        _visibility = true;
                      });
                    },
                    onChangeEnd: (newVibrate) {
                      Vibration.vibrate(duration: 10, amplitude: 1);
                    },
                    value: _weightController,
                    label: '5',
                  ),
                ),
                _buildCustomSlider(
                  "Height",
                  _heightController,
                  "cm",
                  130,
                  250,
                  Slider(
                    inactiveColor: Color.fromRGBO(231, 237, 245, 1),
                    activeColor: Color.fromRGBO(49, 152, 213, 1),
                    min: 130,
                    max: 250,
                    onChanged: (newValue) {
                      setState(() {
                        _heightController =
                            double.parse(newValue.toStringAsFixed(2));
                        _visibility = true;
                      });
                    },
                    onChangeEnd: (newVibrate) {
                      Vibration.vibrate(duration: 10, amplitude: 1);
                    },
                    value: _heightController,
                    label: '5',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomSlider(
      String sliderName, double controller, String unit, double min, double max, Widget slider) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                sliderName,
                style: TextStyle(fontSize: 16, fontFamily: 'Titillium'),
              ),
              Visibility(
                visible: _visibility,
                child: Container(
                  transform: Matrix4.translationValues(0, 10, 0),
                  child: Card(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${controller == null ? "" : "$controller $unit"}',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Titillium',
                              color: Color.fromRGBO(65, 200, 235, 1),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          slider,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '$min $unit',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Titillium',
                  color: Color.fromRGBO(77, 91, 127, 1),
                ),
              ),
              Text(
                '$max $unit',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Titillium',
                  color: Color.fromRGBO(77, 91, 127, 1),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // final height = size.height/2.5;
    final height = 164.0 * 2;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Color.fromRGBO(0, 10, 238, 1);
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    ovalPath.moveTo(0, height);
    ovalPath.quadraticBezierTo(
        width * 1.2, height * 3, width * 1, height * 0.75);
    paint.color = Colors.grey[100];
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
