import 'package:flutter/material.dart';

import 'controller.dart';


class HOME extends StatefulWidget {
  @override
  _HOMEState createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          CustomSwitch(),
        ],
      ),
      body: SingleChildScrollView(
          child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (text){
                  email = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                 onChanged: (text){
                  password = text;
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 15,),
              RaisedButton(
                child: Text("Entrar"),
                onPressed: (){
                  if(email == 'gabrielclash137@gmail.com' &&
                   password == '93012155'){
                   // Navigator.of(context).pushReplacementNamed('/logado');
                  }
                }
                ),
            ],
          ),
          ),
        ),
      ),   
    );
  }
}

class CustomSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Switch(
          value: AppController.instance.isDartTheme ,
          onChanged: (value){
            AppController.instance.changeTheme();
          },
          );
  }
}