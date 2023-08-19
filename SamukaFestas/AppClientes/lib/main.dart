import 'package:AppClientes/CustomSearchDelegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'Telas/Carteira.dart';
import 'Telas/Festa.dart';
import 'Telas/Fretes.dart';
import 'Telas/Mapa.dart';
import 'Telas/Perfil.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

var _pagina = 0;



  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      Festa(),
      Fretes(),
      Mapa(),
      Carteira(),
      Perfil(),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: Text("Samuka Festas",),
        actions: <Widget>[
          IconButton(icon: Icon(Feather.search), onPressed: () async{
            String resultado = await showSearch(context: context, delegate: CustomSearchDelegate());
            print(resultado);
          }),
          IconButton(icon: Icon(FontAwesome.calendar), onPressed: (){}),
        ],
      ),

      drawer: Drawer(
        child: ListView(
        children: <Widget>[
        
              UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black87,
              ),
              currentAccountPicture: null,
              accountName: Text("Edival Samuel Arcangelo"),
              accountEmail: Text("Opoetasamuel@hotmail.com"),
            ),
          
          ListTile(title: Text("Clientes"),
          ),
          ListTile(title: Text("Configurações")),
        ],
      ),),
      

      body: SafeArea(
        child: telas[_pagina],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pagina,
        onTap: (index){
          setState(() {
            _pagina = index;
          });
        },
        fixedColor: Colors.white,
        items: [
        BottomNavigationBarItem(icon: Icon(Feather.briefcase), label: ("Festas")),
        BottomNavigationBarItem(icon: Icon(Feather.truck), label:("Fretes")),
        BottomNavigationBarItem(icon: Icon(Feather.map_pin), label:("Mapa")),
        BottomNavigationBarItem(icon: Icon(FontAwesome.money), label:("Carteira")),
        BottomNavigationBarItem(icon: Icon(Feather.user), label:("Perfil")),
      ]),
    );
  }
}

