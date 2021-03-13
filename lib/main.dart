import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'components/qr_code.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fazenda Cubo - Sistema de Gestão',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistema de Gestão'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image.asset(
                './images/fazenda_cubo.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                child: Text('Daily Production'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.deepPurple)),
                onPressed: () {},
                color: Colors.lightGreen[600],
                textColor: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                child: Text('Daily Activities'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.deepPurple)),
                onPressed: () {},
                color: Colors.lightGreen[600],
                textColor: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.all(40.0),
            ),
          ],
        ),
      ),
      floatingActionButton: QrcodeButton(),
    );
  }
}
