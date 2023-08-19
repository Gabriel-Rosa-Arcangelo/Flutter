import 'package:flutter/material.dart';
import 'package:flutterando/controller.dart';
import 'home.dart';
import 'logado.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
       animation: AppController.instance,
       builder: (context, child){
         return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: AppController.instance.isDartTheme 
        ? Brightness.dark
        : Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => HOME(),
        '/logado': (context) => Logado(),

      },
      home: HOME(),
    );
    }
    );
  }
}

