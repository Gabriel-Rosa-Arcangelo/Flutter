import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future <File> _getFile() async{
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  List _listaTarefas = [];
  Map<String, dynamic> _ultimaTarefaRemovida = Map(); 
  TextEditingController _controllerTarefa = TextEditingController();

  _salvarTarefa(){
    String textoDigitado = _controllerTarefa.text;
    //criar dados
    Map<String, dynamic> tarefa = Map();
    tarefa["Titulo"] = textoDigitado;
    tarefa["realizada"] = false;

    setState(() {
      _listaTarefas.add(tarefa);
    });
    
    _salvarArquivo();
    _controllerTarefa.text = "";

  }

  _salvarArquivo() async{
    
    var arquivo = await _getFile();

    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString(dados);

  }

  _lerArquivo() async{
    try{
      final arquivo = await _getFile();
      return arquivo.readAsString();
    }catch(e){
      return null;
    }
  }

  

  @override
  void initState() {
    super.initState();
    _lerArquivo().then((dados){
      setState(() {
        _listaTarefas = json.decode(dados);
      });
    });
  }

  Widget criarItemLista(context, index){
    //final item = _listaTarefas[index]['titulo'];
    return Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (direction){
            //recuperar tarefa
            _ultimaTarefaRemovida = _listaTarefas[index];

            _listaTarefas.removeAt(index);
            _salvarArquivo();

            //snackbar
            final snackbar = SnackBar(
              content: Text('Tarefa Removida'),
              action: SnackBarAction(
                label: "Desfazer",
                onPressed: (){
                  setState(() {
                    _listaTarefas.insert(index, _ultimaTarefaRemovida);
                  });
                  _salvarArquivo();
                }
                ),
              );
            Scaffold.of(context).showSnackBar(snackbar);

          },
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.delete,
                  color: Colors.white,
                )
              ],
            ),
          ),
          key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
          child: CheckboxListTile(
                  title: Text( _listaTarefas[index]['titulo']),
                  value: _listaTarefas[index]['realizada'],
                  onChanged: (valorAlterado){
                    setState(() {
                      _listaTarefas[index]['realizada'] = valorAlterado;
                    });
                    _salvarArquivo();
                  },
                   ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Adicionar Tarefa"),
                content: TextField(
                  controller: _controllerTarefa,
                  decoration: InputDecoration(
                    labelText: "Digite sua Tarefa",
                  ),
                  onChanged: (text){

                  },
                ),
                actions: <Widget>[
                  FlatButton(
                  onPressed: ()=>Navigator.pop(context),
                   child: Text("Cancelar"),
                   ),
                   FlatButton(
                  onPressed: (){
                    _salvarTarefa();
                  },
                   child: Text("Salvar"),
                   ),
                ],
              );
          }
          );
        },
        ),
      body: Column(
        children: <Widget>[
          Expanded
          (child:
           ListView.builder(
            itemCount: _listaTarefas.length,
            itemBuilder: criarItemLista
           ),
           ),
        ],
      ),
      
      
    );
  }
}

