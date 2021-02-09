import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
// import 'package:image_picker/image_picker.dart';

class QrcodeButton extends StatefulWidget {
  @override
  _QrcodeButtonState createState() => _QrcodeButtonState();
}

class _QrcodeButtonState extends State<QrcodeButton> {
  _scan() async {
    String cameraScanResult = await scanner.scan();

    return AlertDialog(
        title: Text("Raque 1"),
        content: Text(cameraScanResult),
        actions: <Widget>[
          FlatButton(onPressed: null, child: Text("Salvar")),
          FlatButton(onPressed: null, child: Text("Descartar")),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.qr_code,
        color: Colors.white,
      ),
      onPressed: _scan,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
