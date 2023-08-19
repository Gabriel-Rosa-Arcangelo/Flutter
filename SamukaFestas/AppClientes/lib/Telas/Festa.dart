import 'package:flutter/material.dart';

class Festa extends StatefulWidget {
  @override
  _FestaState createState() => _FestaState();
}

class _FestaState extends State<Festa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Column(
            children: <Widget>[

            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 40),
              child: Center(
                child: Text("PEDIDOS",
                style: TextStyle(
                fontSize: 20,
                letterSpacing: 3,
                ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Comestíveis", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 20,),
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        makeItem(image: 'images/pipoca.jpg'),
                        makeItem(image: 'images/rosaazul.jpg'),
                        makeItem(image: 'images/pipocaalgodão.jpeg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Brinquedos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 20,),
                   Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        makeItem(image: 'images/Picina.jpg'),
                        makeItem(image: 'images/pulapula.jpg'),
                        makeItem(image: 'images/doisB.jpg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Artistico", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 20,),
                   Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        makeItem(image: 'images/pipoca.jpg'),
                        makeItem(image: 'images/Algodão.jpg'),
                        makeItem(image: 'images/doisB.jpg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                ],
                ),
            ),
           

          ],
        ),
      ),
    );
  }
}

Widget makeItem({image}){
  return AspectRatio(
    aspectRatio: 1 / 1,
    child: Container(
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.cover,
        ),
      ),
    ),
    );
}