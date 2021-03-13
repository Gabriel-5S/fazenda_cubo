import 'package:flutter/foundation.dart';

class Verdura {
  String qrcode;
  String tipo;
  int dataHorario;
  Verdura(
      {@required this.qrcode, @required this.tipo, @required this.dataHorario});

  Map<String, dynamic> toMap() {
    return {
      'qrCode': qrcode,
      'tipo': tipo,
      'dataHorario': dataHorario,
    };
  }
}
