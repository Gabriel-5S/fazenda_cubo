import 'package:FAZENDA_CUBO/models/verdura.dart';
import 'package:FAZENDA_CUBO/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeedingScreen extends StatefulWidget {
  String qrcode;
  SeedingScreen(this.qrcode);

  @override
  _SeedingScreenState createState() => _SeedingScreenState();
}

class _SeedingScreenState extends State<SeedingScreen> {
  final _qtdFocusNode = FocusNode();
  final _verduraFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  String _tipoVerdura;
  int _qtdVerdura;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _createVerdura(BuildContext context) async {
    final form = _form.currentState;
    //salvando formulário
    form.save();
    final database = Provider.of<Database>(context, listen: false);
    final qrcode = await database.createVerduras(
      Verdura(
          qrcode: widget.qrcode, tipo: _tipoVerdura, qtdVerdura: _qtdVerdura),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plantação'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _createVerdura(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'QR Code'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_verduraFocusNode);
                },
                initialValue: widget.qrcode,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Verdura'),
                textInputAction: TextInputAction.next,
                focusNode: _verduraFocusNode,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_qtdFocusNode);
                },
                onSaved: (value) => _tipoVerdura = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantidade'),
                textInputAction: TextInputAction.next,
                focusNode: _qtdFocusNode,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSaved: (value) => _qtdVerdura = int.tryParse(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
