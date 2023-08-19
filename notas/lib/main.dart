import 'package:flutter/material.dart';
import 'package:notas/helper/AnotacaoHelper.dart';
import 'package:notas/model/Anotacao.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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

  TextEditingController _titulo = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  var _db = AnotacaoHelper();
  List<Anotacao> _anotacoes = List<Anotacao>();

  _exibirTelaCadastro({Anotacao anotacao}){
   
   String textoSalvarAtualizar = "";
    if(anotacao == null){
      textoSalvarAtualizar = "Salvar";
      _titulo.text = "";
      _descricao.text = "";
    }else{
      textoSalvarAtualizar = "Atualizar";
      _titulo.text = anotacao.titulo;
      _descricao.text = anotacao.descricao;
    }

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("$textoSalvarAtualizar anotações"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _titulo ,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Titulo",
                  hintText: "Digite título...",
                ),
              ),
              TextField(
                controller: _descricao ,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Descricao",
                  hintText: "Digite descricao...",
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: ()=> Navigator.pop(context),
              child: Text("Cancelar")
              ),
               FlatButton(
              onPressed: (){
                //salvar
                _salvarAtualizarAnotacao(anotacaoSelecionada: anotacao);
              },
              child: Text(textoSalvarAtualizar)
              ),
          ],
        );
      }
      );
  }
  _salvarAtualizarAnotacao({Anotacao anotacaoSelecionada}) async {
    String titulo = _titulo.text;
    String descricao = _descricao.text;

    if(anotacaoSelecionada == null){//Salvando
      Anotacao anotacao = Anotacao(titulo,descricao,DateTime.now().toString());
      int resultado = await _db.salvarAnotacao(anotacao);
    }else{//Atualizando
      anotacaoSelecionada.titulo    = titulo;
      anotacaoSelecionada.descricao = descricao;
      anotacaoSelecionada.data      = DateTime.now().toString();
      int resultado =await _db.atualizarAnotacao(anotacaoSelecionada);
    }

    

    _titulo.clear();
    _descricao.clear();

    _recuperarAnotacoes();

  }

  _recuperarAnotacoes()async{
    List anotacoesRecuperadas = await _db.recuperarAnotacoes();
    List<Anotacao> listaTemporaria = List<Anotacao>();
    for(var item in anotacoesRecuperadas){
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }
    setState(() {
      _anotacoes = listaTemporaria;
    });
    listaTemporaria = null;
  }

  _formatarData(String data){
    initializeDateFormatting("pt_BR");
    var formatador = DateFormat("d-MM-y");
    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);
    return dataFormatada;
  }

  _removerAnotacao(int id)async{
    await _db.removerAnotacao(id);
    _recuperarAnotacoes();
  }

  @override
  void initState() {
    super.initState();
    _recuperarAnotacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Anotações"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _anotacoes.length,
              itemBuilder: (context, index){
                final anotacao = _anotacoes[index];
                return Card(
                  child: ListTile(
                    title: Text(anotacao.titulo),
                    subtitle: Text("${_formatarData(anotacao.data)} - ${anotacao.descricao}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            _exibirTelaCadastro(anotacao: anotacao);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _removerAnotacao(anotacao.id);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              )
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _exibirTelaCadastro();
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        ),

    );
  }
}

