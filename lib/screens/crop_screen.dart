import 'package:FAZENDA_CUBO/models/verdura.dart';
import 'package:FAZENDA_CUBO/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerduraListTile extends StatelessWidget {
  final Verdura verdura;
  final VoidCallback onTap;

  const VerduraListTile({Key key, @required this.verdura, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(verdura.tipo),
      onTap: onTap,
    );
  }
}

class CropScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Colheita"),
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Verdura>>(
      stream: database.verdurasStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final verduras = snapshot.data;
          final children = verduras
              .map((verdura) => VerduraListTile(
                    verdura: verdura,
                    onTap: () {},
                  ))
              .toList();
          return ListView(children: children);
        }
        if (snapshot.hasError) {
          return Center(child: Text('Some error occurred'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
