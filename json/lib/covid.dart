import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Covid extends StatefulWidget {
  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {

Future<List<Cases>> _getCases() async{
  String url = "https://covid19-brazil-api.now.sh/api/report/v1/brazil";
  var data = await http.get(url);
  var dataJson = json.decode(data.body);
  List<Cases> corona = [];
   for (var u in dataJson){
    Cases cases = Cases(u["cases"],u["confirmed"],u["deaths"],u["recovered"]);
    corona.add(cases);
  }
  return corona;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text('Covid API'),
        ),
        body: FutureBuilder(
          future: _getCases(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: CircularProgressBar() ,
                    ),
                );
           }else{
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom:20),
                  child: Text("Número de casos: "+snapshot.data.cases,
                  textAlign: TextAlign.start,),
                  ),
                  Padding(
                  padding: EdgeInsets.only(bottom:20),
                  child: Text("Número de confirmados: "+snapshot.data.confirmed,
                  textAlign: TextAlign.start,),
                  ),
                  Padding(
                  padding: EdgeInsets.only(bottom:20),
                  child: Text("Número de mortes: "+snapshot.data.deaths,
                  textAlign: TextAlign.start,),
                  ),
                  Padding(
                  padding: EdgeInsets.only(bottom:20),
                  child: Text("Número de recuperados: "+snapshot.data.recovered,
                  textAlign: TextAlign.start,),
                  ),
                  FloatingActionButton.extended(
                    onPressed: null,
                     label: Text('Próximo'))
              ],
            );
          }
          }
          ),
    );
  }
}

class Cases{
  final int cases;
  final int confirmed;
  final int deaths;
  final int recovered;
  Cases(this.cases,this.confirmed,this.deaths,this.recovered);
}