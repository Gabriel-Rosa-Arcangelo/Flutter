import 'package:flutter/material.dart';
import 'dart:async';

import 'TelaInicial.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

@override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),()=> 
    Navigator.push(context,MaterialPageRoute(builder: (context)=>TelaInicial())));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 70.0,
                            child: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                              size: 70.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:30.0),
                           ),
                           Text("CRIPTO RC4",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 30.0,
                             fontWeight: FontWeight.bold,
                           ),
                           ),
                           Padding(
                            padding: EdgeInsets.only(top:120.0,bottom:80.0),
                            child: SizedBox(
                              height: 40.0,
                              width: 40.0,
                                child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey) ,
                                strokeWidth: 5.0,
                              ),
                            ),
                           ),
                            Text("CARREGANDO...",
                        style: TextStyle(
                             color: Colors.white,
                             fontSize: 20.0,
                             fontWeight: FontWeight.bold,
                        ),
                        ),
                  
                        ],
                      )
                    )
                  ),
                ],
              )
          ],
        ),
    );
  }
}

