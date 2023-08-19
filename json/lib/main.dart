import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'covid.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estudo de API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

Future<List<User>> _getUser() async{
  String url = "http://jsonplaceholder.typicode.com/users";
  var data = await http.get(url);
  var dataJson = json.decode(data.body);
  List<User> users = [];
  for (var u in dataJson){
    User user = User(u["id"],u["name"],u["email"],u["picture"]);
    users.add(user);
  }
  return users;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,),
        centerTitle: true, 
        ),
      body: Container(
      child: Column(
        children: <Widget>[
          FutureBuilder(
        future: _getUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading...") ,
                    ),
                );
          }else{
          return Expanded (
            
            child: Padding(
              padding: EdgeInsets.fromLTRB(10,0,10,10),
              child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://source.unsplash.com/random",
                    ),
                  ),
                  title: Text(snapshot.data[index].name),
                  subtitle: Text(snapshot.data[index].email),
                  onTap: (){
                    Navigator.push(context,
                   MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                   );
                  }
                );
              },
              ),
            ) 
          );
          }
        }
        ),
        FloatingActionButton.extended(
          label: Text('Próximo estudo'),
          backgroundColor: Colors.lightBlue[500],
          foregroundColor: Colors.white,
          onPressed: (){
            Navigator.push(context,
             MaterialPageRoute(builder: (context)=> Covid())
             );
          }
          ),
          Padding(padding: EdgeInsets.only(top:10))
        ],
      
       
      ),
      )
    );
  }
}

class User{
  final int id;
  final String picture;
  final String name;
  final String email;
  User(this.id,this.name,this.email,this.picture);
}

class DetailPage extends StatelessWidget {
  final User user;
  DetailPage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
    );
  }
}

