import 'package:flutter/material.dart';
import 'dart:math';
import 'bfcalc.dart';

class IPF extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new IPFState();
  }
}


class IPFState extends State<IPF>{
  final TextEditingController _genderController = new TextEditingController();
  final TextEditingController _weightController = new TextEditingController();
  final TextEditingController _totalController = new TextEditingController();
  double _result = 0.0;
  String _finalResultPrint = "";
  String _doneResult = "";

  void _clear(){
    setState(() {
      _genderController.clear();
      _weightController.clear();
      _totalController.clear();
    });
  }

  void _bfValue(){
    setState(() {
      double gender = double.parse(_genderController.text);
      double weight = double.parse(_weightController.text);
      double total = double.parse(_totalController.text);

      if((_genderController.text.isNotEmpty || gender > 0 || gender <= 2) && ((_totalController.text.isNotEmpty || total > 0) && (_weightController.text.isNotEmpty || weight > 0))){
        var c1 = 310.67;
        var c2 = 857.7850;
        var c3 = 53.216;
        var c4 = 147.0835;
        _result = 500+100*(total - (c1*log(weight)-c2)/(c3*log(weight)-c4));
        print(_result);
      }else{
        print("Error");
      }

      if((double.parse(_result.toStringAsFixed(1)) < 18.5)){
        _finalResultPrint = "UnderWeight";
        print(_finalResultPrint);
      }else if(double.parse(_result.toStringAsFixed(1))>18.5 &&
          (double.parse(_result.toStringAsFixed(1)) <=25.0)){
        _finalResultPrint = "Normal";
        print(_finalResultPrint);
      }else if((double.parse(_result.toStringAsFixed(1))>25.0)
          && (double.parse(_result.toStringAsFixed(1))) < 30.0){
        _finalResultPrint = "OverWeight";
        print(_finalResultPrint);
      }else if((double.parse(_result.toStringAsFixed(1))) >= 30.0){
        _finalResultPrint = "Obesity";
        print(_finalResultPrint);
      }

    });

    _doneResult = "Your IPF is ${_result.toStringAsFixed(1)} ";
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
                    onPressed: () {Navigator.pop(context); },
                    color: Colors.white,
                  ),
                  Text("Navigate", style: TextStyle(color: Colors.white),),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent
              ),
            ),
            ListTile(
              title: Text("BFCalc"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Home()
                ));
              },
            ),ListTile(
              title: Text("IPFCalc"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => IPF()
                ));
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
      appBar: new AppBar(
        title: new Text("IPF Calc"),
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
                    controller: _totalController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: "Eg 120-1000",
                      labelText: "Total",
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





