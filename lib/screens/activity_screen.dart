import 'package:FAZENDA_CUBO/screens/crop_screen.dart';
import 'package:FAZENDA_CUBO/screens/seeding_screen.dart';
import 'package:FAZENDA_CUBO/screens/task_screen.dart';
import 'package:flutter/material.dart';

import '../models/local.dart';

class ActivityScreen extends StatelessWidget {
  Local local;

  ActivityScreen(this.local);

  _selectActivity(BuildContext context, String task) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        switch (task) {
          case "planta":
            return SeedingScreen();
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
