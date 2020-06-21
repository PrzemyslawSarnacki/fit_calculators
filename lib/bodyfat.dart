import 'dart:js';
import 'dart:js_util';
import 'package:flutter/material.dart';
import 'dart:math';
import 'custom_drawer.dart';

import 'package:flutter/cupertino.dart';
import 'package:vibration/vibration.dart';

class Bodyfat extends StatefulWidget {
  Bodyfat({Key key}) : super(key: key);

  @override
  _BodyfatState createState() => _BodyfatState();
}

class _BodyfatState extends State<Bodyfat> {

  double _result = 0.0;
  String _finalResultPrint;
  String _genderController = "male";
  double _heightController = 175;
  double _waistController = 80;
  double _neckController = 21;
  bool _visibility = false;

  void _bfValue() {
    setState(() {
      String gender = _genderController;
      double height = _heightController;
      double waist = _waistController;
      double neck = _neckController;

      if ((gender == "male") && ((height > 0) && (waist > 0) && (neck > 0))) {
        _result = ((495) /
                (1.0324 -
                    (0.19077 * (log(waist - neck) / 2.303)) +
                    (0.15456 * log(height) / 2.303))) -
            450;
        _result = double.parse(_result.toStringAsFixed(2));
      } else if ((gender == "female") &&
          ((height > 0) && (waist > 0) && (neck > 0))) {
        _result = ((495) /
                (1.29579 -
                    (0.35004 * (log(waist - neck) / 2.303)) +
                    (0.22100 * log(height) / 2.303))) -
            450;
        _result = double.parse(_result.toStringAsFixed(2));
      } else {
        print("Error");
      }

      if ((double.parse(_result.toStringAsFixed(1)) > 5.0 &&
          double.parse(_result.toStringAsFixed(1)) < 8.5)) {
        _finalResultPrint = "Aleś dociął byku";
      } else if (double.parse(_result.toStringAsFixed(1)) > 8.5 &&
          (double.parse(_result.toStringAsFixed(1)) <= 10.0)) {
        _finalResultPrint = "No spoko jest";
      } else if ((double.parse(_result.toStringAsFixed(1)) > 10) &&
          (double.parse(_result.toStringAsFixed(1))) < 15.0) {
        _finalResultPrint = "Nie jest źle";
      } else if ((double.parse(_result.toStringAsFixed(1))) > 15.0 &&
          (double.parse(_result.toStringAsFixed(1))) < 18.0) {
        _finalResultPrint = "Jeszcze nie ulany";
      } else if ((double.parse(_result.toStringAsFixed(1))) >= 18.0) {
        _finalResultPrint = "Po prostu schudnij ulańcu";
      } else if ((double.parse(_result.toStringAsFixed(1))) < 5.0) {
        _finalResultPrint =
            "Umówmy się no nie masz tyle - coś ci się chyba skasztaniło byczq";
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: CustomDrawer.of(context),
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
                      CustomDrawer.of(context).open();
                    },
                  ),
                ),
                Text(
                  'Calculated Body Fat Percentage',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Titillium',
                  ),
                ),
                Text(
                  '${_result == null ? "---" : "$_result%"}',
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: "female",
                      groupValue: _genderController,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          _genderController = value;
                        });
                      },
                    ),
                    Text('Female'),
                    SizedBox(width: 20),
                    Radio(
                      value: "male",
                      activeColor: Colors.blue,
                      groupValue: _genderController,
                      onChanged: (value) {
                        setState(() {
                          _genderController = value;
                        });
                      },
                    ),
                    Text("Male"),
                  ],
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
                ),
                _buildCustomSlider(
                  "Waist",
                  _waistController,
                  "cm",
                  30,
                  150,
                  Slider(
                    inactiveColor: Color.fromRGBO(231, 237, 245, 1),
                    activeColor: Color.fromRGBO(49, 152, 213, 1),
                    min: 30,
                    max: 150,
                    onChanged: (newValue) {
                      setState(() {
                        _waistController =
                            double.parse(newValue.toStringAsFixed(2));
                        _visibility = true;
                      });
                    },
                    onChangeEnd: (newVibrate) {
                      Vibration.vibrate(duration: 10, amplitude: 1);
                    },
                    value: _waistController,
                    label: '5',
                  ),
                ),
                _buildCustomSlider(
                  "Neck",
                  _neckController,
                  "cm",
                  20,
                  100,
                  Slider(
                    inactiveColor: Color.fromRGBO(231, 237, 245, 1),
                    activeColor: Color.fromRGBO(49, 152, 213, 1),
                    min: 20,
                    max: 100,
                    onChanged: (newValue) {
                      setState(() {
                        _neckController =
                            double.parse(newValue.toStringAsFixed(2));
                        _visibility = true;
                      });
                    },
                    onChangeEnd: (newVibrate) {
                      Vibration.vibrate(duration: 10, amplitude: 1);
                    },
                    value: _neckController,
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

  Widget _buildCustomSlider(String sliderName, double controller, String unit,
      double min, double max, Widget slider) {
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
