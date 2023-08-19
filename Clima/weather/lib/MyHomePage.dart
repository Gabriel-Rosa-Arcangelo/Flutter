import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _atual = "";
  String _condicao = "";
  String _humidade = "";
  String _vento = "";
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("APP CLIMA"),
      backgroundColor: Colors.blue,),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top:130),
          child: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                    Text(
                    "Temperatura atual: "+ _atual,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                   "Condição atual: "+ _condicao,
                   textAlign: TextAlign.start,
                    style: TextStyle(
                    fontSize: 20,
                  ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(bottom:30),
                   child: Text(
                   "Porcentagem de humidade: "+ _humidade,
                   textAlign: TextAlign.start,
                    style: TextStyle(
                    fontSize: 20,
                  ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:60),
                    child: Text(
                    "Velocidade do vento: "+ _vento,
                    textAlign: TextAlign.start,
                     style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                 RaisedButton(    
                    padding: EdgeInsets.all(0.0),         
                    onPressed: () async{
                      String url = "https://api.hgbrasil.com/weather?woeid=448985";
                      http.Response response = await http.get(url);
                      Map<String,dynamic> retorno = json.decode(response.body);
                      setState(() {
                        _atual = retorno["results"]["temp"].toString();
                        _condicao = retorno["results"]["description"].toString();
                        _humidade = retorno["results"]["humidity"].toString();
                        _vento = retorno["results"]["wind_speedy"].toString();
                      });
  
                    } ,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(75, 15, 75, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(colors: <Color>[
                          Colors.blue[500],
                          Colors.blue[400],
                          Colors.blue[300],
                        ])
                      ),
                      child: Text(
                        "Verificar",
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 20,
                        ),
                        ),
                    ),
                    ),   
              ],
            ),
          ),
        ),
      ),
    );
  }
}