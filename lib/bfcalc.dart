import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}


class HomeState extends State<Home>{
  final TextEditingController _genderController = new TextEditingController();
  final TextEditingController _weightController = new TextEditingController();
  final TextEditingController _heightController = new TextEditingController();
  final TextEditingController _waistController = new TextEditingController();
  final TextEditingController _neckController = new TextEditingController();
  double _result = 0.0;
  String _finalResultPrint = "";
  String _doneResult = "";

  void _clear(){
    setState(() {
      _genderController.clear();
      _weightController.clear();
      _heightController.clear();
      _waistController.clear();
      _neckController.clear();
    });
  }

  void _bfValue(){
    setState(() {
      double gender = double.parse(_genderController.text);
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text);
      double waist = double.parse(_waistController.text);
      double neck = double.parse(_neckController.text);

      if((_genderController.text.isNotEmpty || gender > 0 || gender <= 2) && ((_heightController.text.isNotEmpty || height > 0) && (_weightController.text.isNotEmpty || weight > 0) && (_waistController.text.isNotEmpty || waist > 0) && (_neckController.text.isNotEmpty || neck > 0))){
        _result = ((495) / (1.0324 - (0.19077 * (log(waist - neck)/2.303)) + (0.15456 * log(height)/2.303))) - 450;
      }else{
        print("Error");
      }

      if((double.parse(_result.toStringAsFixed(1)) < 8.5)){
        _finalResultPrint = "Aleś dociął byku";
        print(_finalResultPrint);
      }else if(double.parse(_result.toStringAsFixed(1))>8.5 &&
          (double.parse(_result.toStringAsFixed(1)) <=10.0)){
        _finalResultPrint = "No spoko jest";
        print(_finalResultPrint);
      }else if((double.parse(_result.toStringAsFixed(1))>10)
          && (double.parse(_result.toStringAsFixed(1))) < 15.0){
        _finalResultPrint = "Nie jest źle";
        print(_finalResultPrint);
      }else if((double.parse(_result.toStringAsFixed(1))) > 15.0
          && (double.parse(_result.toStringAsFixed(1))) < 18.0) {
        _finalResultPrint = "Jeszcze nie ulany";
        print(_finalResultPrint);
      }else if((double.parse(_result.toStringAsFixed(1))) >= 18.0){
        _finalResultPrint = "Po prostu schudnij kurwa ulańcu jebany";
        print(_finalResultPrint);
    }
    });

    _doneResult = "Your BodyFat is ${_result.toStringAsFixed(1)} %";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
                DrawerHeader(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {Navigator.pop(context); }
                        ,
                      ),
                      Text("Navigate"),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent
                  ),
                ),
            ListTile(
              title: Text("Head"),
              onTap: (){
                Navigator.pop(context);
              },
            ),ListTile(
              title: Text("Head1"),
              onTap: (){
                Navigator.pop(context);
              },
            ),ListTile(
              title: Text("Head2"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      //AppBar
      appBar: new AppBar(
        title: new Text("BfCalc"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),

      //Body
      body: new Container(
        child: new ListView(
          children: <Widget>[
            new Center(
              child: new Column(
                children: <Widget>[
                  new IconButton(icon : Icon (Icons.line_weight),
                    iconSize: 200.0, onPressed: null,
                  ),

                  //TextField
                  new TextField(
                    controller: _genderController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: "Eg 1-2",
                      labelText: "Gender",
                      icon: Icon(Icons.person),
                    ),
                  ),

                  new TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: "Eg 120-200",
                      labelText: "Height",
                      icon: Icon(Icons.bubble_chart),
                    ),
                  ),

                  new TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: "Eg 0-100",
                      labelText: "Weight",
                      icon: Icon(Icons.line_weight),
                    ),
                  ), new TextField(
                    controller: _waistController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: "Eg 0-100",
                      labelText: "Waist",
                      icon: Icon(Icons.linear_scale),
                    ),
                  ), new TextField(
                    controller: _neckController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: "Eg 0-100",
                      labelText: "Neck",
                      icon: Icon(Icons.hearing),
                    ),
                  ),
                  new Padding(padding: EdgeInsets.all(10.0)),

                  new Row(
                    children: <Widget>[
                      new Container(
                          margin: EdgeInsets.only(left: 100.0),
                          child: new RaisedButton(
                            onPressed: _bfValue,
                            color: Colors.deepPurple,
                            child: new Text(
                              "Calculate",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          )),
                      new Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: new RaisedButton(
                            onPressed: _clear,
                            color: Colors.deepPurple,
                            child: new Text(
                              "Clear",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ))
                    ],
                  ),
                  new Padding(padding: EdgeInsets.all(10.0)),

                  new Text(
                    '$_doneResult',
                    style: new TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54),
                  ),

                  new Text(
                    "$_finalResultPrint",
                    style: new TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}





