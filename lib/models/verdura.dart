import 'package:flutter/foundation.dart';

class Verdura {
  String qrcode;
  String tipo;
  int qtdVerdura;
  Verdura(
      {@required this.qrcode, @required this.tipo, @required this.qtdVerdura});

  Map<String, dynamic> toMap() {
    return {
      'qrCode': qrcode,
      'tipo': tipo,
      'qtdVerdura': qtdVerdura,
    };
  }
}
