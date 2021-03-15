import 'package:FAZENDA_CUBO/models/verdura.dart';
import 'package:FAZENDA_CUBO/screens/crop_screen.dart';
import 'package:FAZENDA_CUBO/screens/seeding_screen.dart';
import 'package:FAZENDA_CUBO/screens/task_screen.dart';
import 'package:FAZENDA_CUBO/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/local.dart';

class ActivityScreen extends StatelessWidget {
  Local local;

  ActivityScreen(this.local);
  //TODO Incluir passagem do QR code para a tela Seeding Screen()
  _selectActivity(BuildContext context, String task) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        switch (task) {
          case "planta":
            return Provider<Database>(
              create: (_) => FirestoreDatabase(
                  uid: "Aqui Vai entrar o login de quem acessar o DB"),
              child: SeedingScreen(local.id),
            );
          case "colhe":
            return CropScreen();
          case "tarefa":
            return TaskScreen();
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Atividades do Local ${local.id}'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    child: Text('Plantação'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.deepPurple)),
                    onPressed: () => _selectActivity(context, "planta"),
                    color: Colors.lightGreen[600],
                    textColor: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    child: Text('Colheita'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.deepPurple)),
                    onPressed: () => _selectActivity(context, "colhe"),
                    color: Colors.lightGreen[600],
                    textColor: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    child: Text('Tarefas'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.deepPurple)),
                    onPressed: () => _selectActivity(context, "tarefa"),
                    color: Colors.lightGreen[600],
                    textColor: Colors.white,
                  ),
                ),
              ]),
        ));
  }
}
