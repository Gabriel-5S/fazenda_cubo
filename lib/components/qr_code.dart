import 'package:FAZENDA_CUBO/models/verdura.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../screens/activity_screen.dart';
import '../models/local.dart';

class QrcodeButton extends StatefulWidget {
  @override
  _QrcodeButtonState createState() => _QrcodeButtonState();
}

class _QrcodeButtonState extends State<QrcodeButton> {
  _scanner(BuildContext context) async {
    String cameraScanResult = await scanner.scan();

    Local local = new Local();
    Verdura verdura = new Verdura();
    verdura.qrcode = cameraScanResult;
    local.id = cameraScanResult;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return ActivityScreen(local, verdura);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.qr_code,
        color: Colors.white,
      ),
      onPressed: () => _scanner(context),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
