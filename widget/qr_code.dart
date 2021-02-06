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
    // Scaffold.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(cameraScanResult),
    //     backgroundColor: Theme.of(context).primaryColor,
    //   ),
    // );
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
