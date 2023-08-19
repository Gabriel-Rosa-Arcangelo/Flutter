import 'package:flutter/material.dart';

class Logado extends StatefulWidget {
  @override
  _LogadoState createState() => _LogadoState();
}

class _LogadoState extends State<Logado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logado Page"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              /*currentAccountPicture: ClipRect(
                //child: Image.network(src),
                
              ),*/
              accountName: Text("Gabriel Rosa"),
              accountEmail: Text('gabrielclash137@gmail.com'),
               ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              subtitle: Text('Tela de inicio'),
              onTap: (){}
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              subtitle: Text('Finalizar sessão'),
              onTap: (){
               // Navigator.of(context).pushReplacementNamed('/');
              }
            ),
          ]
        ),
      ),
    );
  }
}