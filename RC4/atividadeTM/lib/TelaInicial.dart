import 'package:flutter/material.dart';
import 'package:simple_rc4/simple_rc4.dart';
import 'dart:convert';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  static TextEditingController _textoDigitado = TextEditingController();
  static TextEditingController _chave = TextEditingController();
  static TextEditingController _textoCifrado = TextEditingController();

  static var rc4 = RC4(_chave.text);
  static var input = _textoDigitado.text;
  static var _bytes = rc4.encodeBytes(utf8.encode(input));
  static var rc5 = RC4(_chave.text);
  static var _output = rc5.decodeBytes(_bytes);
  
  /*void _imp(){
  var rc4 = RC4(_chave.text);
  var input = _textoDigitado.text;
  var bytes = rc4.encodeBytes(utf8.encode(input));
  rc4 = RC4(_chave.text);
  var output = rc4.decodeBytes(bytes);
  print(output);*/

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                                child: TextField(
                    controller: _textoDigitado,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black87,
                      labelText: "Texto",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: "Digite o texto para criptografar",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onChanged: (_textoDigitado){},
                    autofocus: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                                child: TextField(
                    controller: _chave,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black87,
                    
                      labelText: "Chave",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: "Digite a chave da criptografia",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onChanged: (_textoDigitado){},
                    autofocus: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                                child: TextField(
                    controller: _textoCifrado,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black87,
                      labelText: "Criptografia",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: "Número criptografado",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                      
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onChanged: (_textoDigitado){
                    },
                    autofocus: true,
                  ),
                ),
                OutlineButton(
                  onPressed: (){
                    _textoCifrado.text = _bytes.toString();
                    _textoDigitado.clear();
                    _textoDigitado.text = '';
                  },
                  padding: EdgeInsets.only(top: 20.0, bottom: 20, left: 30,right: 30),
                  child: Text("Criptografar",
                  style: TextStyle(
                    color: Colors.grey,
                  )),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  ),
                  OutlineButton(
                  onPressed: (){
                    _textoDigitado.text = _output.toString();
                    _textoCifrado.clear();
                    _textoCifrado.text = '';
                  },
                  padding: EdgeInsets.all(20.0),
                  child: Text("Descriptografar",
                  style: TextStyle(
                    color: Colors.grey,
                  )),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  ),
              ],
            ),
          ],
         ),
      
    );
  }
}