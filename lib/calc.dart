import 'dart:js';
import 'package:flutter/material.dart';
import 'dart:math';
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
  int endValue;
  TextEditingController amount = new TextEditingController();
  var amountTempFinal;
  int dropdownValue = 3;
  double _result = 0.0;
  String _finalResultPrint = "";
  double _slidervalue = 131.0;
  double _weightController;
  double _heightController;
  var temp1;
  bool _visibility = false;

  void _bfValue() {
    setState(() {
      double weight = _weightController;
      double height = _heightController;

      if (((height > 0) && (weight > 0))) {
        _result = weight / (height * height / 100 / 100);
        print(_result);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () {},
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
                  '\$ ${endValue == null ? "---" : "$endValue"}',
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.white,
                    fontFamily: 'Titillium',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(22, 9, 22, 9),
                    color: Color.fromRGBO(65, 200, 235, 1),
                    onPressed: () {
                      var amountFinal = double.parse(amount.text);
                      if ((amountFinal != null) &&
                          (_slidervalue != null) &&
                          (dropdownValue != null)) {
                        _slidervalue = (_slidervalue / 100) + 1;
                        setState(() {
                          double temp1 =
                              amountFinal * pow(_slidervalue, dropdownValue);
                          endValue = temp1.toInt();
                        });
                      }
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
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Weight',
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Titillium'),
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
                                        '${temp1 == null ? "" : "$temp1 %"}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Titillium',
                                          color:
                                              Color.fromRGBO(65, 200, 235, 1),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        '${amountTempFinal == null ? "" : "\$ $amountTempFinal"}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Titillium',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        inactiveColor: Color.fromRGBO(231, 237, 245, 1),
                        activeColor: Color.fromRGBO(49, 152, 213, 1),
                        min: 130,
                        max: 250,
                        onChanged: (newInterest) {
                          setState(() {
                            _slidervalue = newInterest;
                            temp1 =
                                double.parse(newInterest.toStringAsFixed(2));
                            _visibility = true;
                          });
                        },
                        onChangeEnd: (newVibrate) {
                          Vibration.vibrate(duration: 10, amplitude: 1);
                        },
                        value: _slidervalue,
                        label: '5',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '130 cm',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Titillium',
                        color: Color.fromRGBO(77, 91, 127, 1),
                      ),
                    ),
                    Text(
                      '250 cm',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Titillium',
                        color: Color.fromRGBO(77, 91, 127, 1),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Height',
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Titillium'),
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
                                        '${temp1 == null ? "" : "$temp1 %"}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Titillium',
                                          color:
                                              Color.fromRGBO(65, 200, 235, 1),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        '${amountTempFinal == null ? "" : "\$ $amountTempFinal"}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Titillium',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        inactiveColor: Color.fromRGBO(231, 237, 245, 1),
                        activeColor: Color.fromRGBO(49, 152, 213, 1),
                        min: 130,
                        max: 250,
                        onChanged: (newInterest) {
                          setState(() {
                            _slidervalue = newInterest;
                            temp1 =
                                double.parse(newInterest.toStringAsFixed(2));
                            _visibility = true;
                          });
                        },
                        onChangeEnd: (newVibrate) {
                          Vibration.vibrate(duration: 10, amplitude: 1);
                        },
                        value: _slidervalue,
                        label: '5',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '30 kg',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Titillium',
                        color: Color.fromRGBO(77, 91, 127, 1),
                      ),
                    ),
                    Text(
                      '200 kg',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Titillium',
                        color: Color.fromRGBO(77, 91, 127, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // final height = size.height/2.5;
    final height = 155.0 * 2;
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