import 'package:flutter/material.dart';
import 'package:todoappmaker5000/dao/listaDao.dart';

class dialogNovaLista extends StatefulWidget {
  @override
  _dialogNovaListaState createState() => _dialogNovaListaState();
}

class _dialogNovaListaState extends State<dialogNovaLista> {
  TextEditingController customControllerNome = TextEditingController();

  final dbHelperLista = listaDao.instance;

  void _inserirLista() async {
    // linha para incluir
    Map<String, dynamic> row = {
      listaDao.columnNome: customControllerNome.text,
    };
    final id = await dbHelperLista.insert(row);
    print('linha inserida id LISTA: $id');
  }

  //CHECK ERROR NULL

  String checkProblemas(){
    String erros = "";
    if (customControllerNome.text.isEmpty) {
      erros += "Insira um nome\n";
    }
    if (customControllerNome.text.length > 25) {
      erros += "Nome muito extenso\n";
    }
    return erros;
  }

  showAlertDialogErros(BuildContext context) {

    Widget okButton = FlatButton(
      child: Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: Text(
        "Erro",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        checkProblemas(),
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOVA LISTA'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15,
            ),

            TextField(
              minLines: 1,
              maxLines: 2,
              maxLength: 25,
              maxLengthEnforced: true,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
              controller: customControllerNome,
              autofocus: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.article),
                  hintText: "Nome",
                  contentPadding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(8.0)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(8.0))),
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          elevation: 0.0,
          onPressed: () {

            if (checkProblemas().isEmpty) {
              _inserirLista();
              Navigator.of(context).pop();
            } else {
              showAlertDialogErros(context);
            }

          },
          child: Icon(
            Icons.save_outlined,
            color: Colors.white,
          ),
          // elevation: 5.0,
        ),
      ),
    );
  }
}
