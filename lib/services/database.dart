import 'package:FAZENDA_CUBO/models/verdura.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'APIPath.dart';

abstract class Database {
  Future<void> createVerduras(Verdura verdura);
  Stream<List<Verdura>> verdurasStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  //final String uid;
  Future<void> createVerduras(Verdura verdura) => _setData(
        path: APIPath.verdura(documentIdFromCurrentDate()),
        data: verdura.toMap(),
      );

  Stream<List<Verdura>> verdurasStream() {
    final path = APIPath.verduras();
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshots) => snapshots.docs.map(
        (snapshot) {
          final data = snapshot.data();
          return data != null
              ? Verdura(
                  qrcode: data['qrcode'],
                  tipo: data['tipo'],
                  qtdVerdura: data['qtdVerdura'],
                )
              : null;
        },
      ).toList(), //Map devolve um iterável é preciso o .toList()
    );
  }

  //útil pq é o ponto de entrada para todos os dados
  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.set(data);
  }
}
