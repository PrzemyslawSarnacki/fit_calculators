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
      home: IPF(),
    ));

class IPF extends StatefulWidget {
  @override
  _IPFState createState() => _IPFState();
}

class _IPFState extends State<IPF> {
  double _result = 0.0;
  String _genderController = "male";
  double _weightController = 90;
  String _categoryController = "Classic 3";
  double _liftedWeightController = 175;
  bool _visibility = false;

  void _ipfPointsValue() {
    setState(() {
      String gender = _genderController;
      String category = _categoryController;
      double liftedWeight = _liftedWeightController;
      double weight = _weightController;

      const Map<String, Map<String, List<double>>> PARAMETERS = {
        "male": {
          "Classic 3": [310.67, 857.785, 53.0216, 147.0835],
          "Bench": [86.4745, 259.155, 17.57845, 53.122],
          "Eq 3": [387.265, 1121.28, 80.6324, 222.4896],
          "Eq Bench": [133.94, 441.465, 35.3938, 113.0057]
        },
        "female": {
          "Classic 3": [125.1435, 228.03, 34.5246, 86.8301],
          "Bench": [25.0485, 43.848, 6.7172, 13.952],
          "Eq 3": [176.58, 373.315, 48.4534, 110.0103],
          "Eq Bench": [49.106, 124.209, 23.199, 67.4926]
        },
      };

      double c1 = PARAMETERS[gender][category][0];
      double c2 = PARAMETERS[gender][category][1];
      double c3 = PARAMETERS[gender][category][2];
      double c4 = PARAMETERS[gender][category][3];
      _result = 500 +
          100 *
              (liftedWeight -
                  (c1 * log(weight) - c2)) / (c3 * log(weight) - c4);
    });
    _result = double.parse(_result.toStringAsFixed(2));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        child: IPF(),
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
                      CustomDrawer.of(context).open();
                    },
                  ),
                ),
                Text(
                  'Calculated IPF Points',
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
                SizedBox(
                  height: 18,
                ),
                Container(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(22, 9, 22, 9),
                    color: Color.fromRGBO(65, 200, 235, 1),
                    onPressed: () {
                      _ipfPointsValue();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: "Classic 3",
                      groupValue: _categoryController,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          _categoryController = value;
                        });
                      },
                    ),
                    Text('3-Lifts'),
                    SizedBox(width: 15),
                    Radio(
                      value: "Bench",
                      activeColor: Colors.blue,
                      groupValue: _categoryController,
                      onChanged: (value) {
                        setState(() {
                          _categoryController = value;
                        });
                      },
                    ),
                    Text("Bench"),
                    SizedBox(width: 15),
                    Radio(
                      value: "Eq 3",
                      activeColor: Colors.blue,
                      groupValue: _categoryController,
                      onChanged: (value) {
                        setState(() {
                          _categoryController = value;
                        });
                      },
                    ),
                    Text("Eq 3-Lifts"),
                    SizedBox(width: 15),
                    Radio(
                      value: "Eq Bench",
                      activeColor: Colors.blue,
                      groupValue: _categoryController,
                      onChanged: (value) {
                        setState(() {
                          _categoryController = value;
                        });
                      },
                    ),
                    Text("Eq Bench"),
                  ],
                ),
                _buildCustomSlider(
                  "Weight",
                  _weightController,
                  "kg",
                  36,
                  230,
                  Slider(
                    inactiveColor: Color.fromRGBO(231, 237, 245, 1),
                    activeColor: Color.fromRGBO(49, 152, 213, 1),
                    min: 36,
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
                  "Lifted Weight",
                  _liftedWeightController,
                  "kg",
                  30,
                  2000,
                  Slider(
                    inactiveColor: Color.fromRGBO(231, 237, 245, 1),
                    activeColor: Color.fromRGBO(49, 152, 213, 1),
                    min: 30,
                    max: 2000,
                    onChanged: (newValue) {
                      setState(() {
                        _liftedWeightController =
                            double.parse(newValue.toStringAsFixed(2));
                        _visibility = true;
                      });
                    },
                    onChangeEnd: (newVibrate) {
                      Vibration.vibrate(duration: 10, amplitude: 1);
                    },
                    value: _liftedWeightController,
                    label: '5',
                  ),
                ),
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
    // final weight = size.weight/2.5;
    final weight = 155.0 * 2;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, weight));
    paint.color = Color.fromRGBO(0, 10, 238, 1);
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    ovalPath.moveTo(0, weight);
    ovalPath.quadraticBezierTo(
        width * 1.2, weight * 3, width * 1, weight * 0.75);
    paint.color = Colors.grey[100];
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
