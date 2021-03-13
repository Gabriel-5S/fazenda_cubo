import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; //Plugin para ler arquivos

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  //Controller para acessar o valor textual digitado na TextField
  final _toDoController = TextEditingController();

  List _toDoList = [];

  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPosition;

  //Função que define o estado inicial da aplicação, com base no que está salvo no diretório
  @override
  void initState() {
    super.initState();

    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  //Adiciona o texto do TextField à lista, atualizando o estado da página e salvando os dados
  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      _toDoController.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _saveData();
    });
  }

  //Ordena as listas após um segundo de espera
  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });
    });
  }

  //A construção da tela Home vem dentro da classe que define o estado da Home
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.lightGreen[600],
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
          child: Row(
            children: <Widget>[
              Expanded(
                //Faz com que o widget se expanda até encaixa na tela, sem precisar definir um tamanho exato
                child: TextField(
                  controller: _toDoController,
                  decoration: InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(color: Colors.lightGreen[600])),
                ),
              ),
              RaisedButton(
                color: Colors.lightGreen[600],
                child: Text("ADD"),
                textColor: Colors.white,
                onPressed: _addToDo,
              ),
            ],
          ),
        ),
        Expanded(
            //Ajusta ao tamanho da tela ou espaço disponível entre widgets
            child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
              //Lista de itens. O builder permite que a lista vá sendo construída, renderizando apenas o necessário, economizando recursos.
              padding: EdgeInsets.only(top: 10.0),
              itemCount: _toDoList.length,
              itemBuilder: buildItem),
        )),
      ]),
    );
  }

  //As funções são colocadas dentro da classe que gerencia o estado da aplicação

  //Gerencia os itens da lista de tarefas
  Widget buildItem(context, index) {
    return Dismissible(
      //Widget que permite arrastar para excluir, por exemplo.
      key: Key(DateTime.now()
          .millisecondsSinceEpoch
          .toString()), //Necessário para diferenciar cada ação efetuada. Pode ser qualquer valor, como string randômica.
      background: Container(
        color: Colors.red,
        child: Align(
          //Widget que alinha o conteúdo (child)
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
        ),
        onChanged: (bool) {
          setState(() {
            _toDoList[index]["ok"] = bool;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        //Ação no dismissible de acordo com a direção em que é puxado - no caso só uma.
        setState(() {
          _lastRemoved =
              Map.from(_toDoList[index]); //Remove o item e salva sem ele.
          _lastRemovedPosition = index;
          _toDoList.removeAt(index);
          _saveData();
        });

        final snackbar = SnackBar(
          content: Text("Tarefa \"${_lastRemoved["title"]}\" removida"),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
              setState(() {
                _toDoList.insert(_lastRemovedPosition,
                    _lastRemoved); //Insere novamente e salva
                _saveData();
              });
            },
          ),
          duration: Duration(seconds: 5),
        );

        Scaffold.of(context).removeCurrentSnackBar();  //Remove a snackbar atual se outro item foi excluído dentro do tempo
        Scaffold.of(context).showSnackBar(snackbar);
      },
    );
  }

  //Encontra o arquivo no diretório e passa o caminho
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  //Salva os dados no arquivo em formato JSON
  Future<File> _saveData() async {
    String data = json.encode(_toDoList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  //Tenta ler o arquivo salvo e retorna a leitura
  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (error) {
      return error;
    }
  }
}

