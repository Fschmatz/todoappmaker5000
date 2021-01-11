import 'package:flutter/material.dart';
import '../util/block_pickerAlterado.dart';
import 'package:todoappmaker5000/dao/categoriaDao.dart';

class dialogNovaCategoria extends StatefulWidget {
  @override
  _dialogNovaCategoriaState createState() => _dialogNovaCategoriaState();

  Function() refreshCategorias;
  dialogNovaCategoria({Key key, this.refreshCategorias}) : super(key: key);
}

class _dialogNovaCategoriaState extends State<dialogNovaCategoria> {
  TextEditingController customControllerNome = TextEditingController();
  TextEditingController customControllerCor = TextEditingController();

  String corAtual = "4294922834";
  final dbHelperCat = categoriaDao.instance;


  void _inserirCategoria() async {
    // linha para incluir
    Map<String, dynamic> row = {
      categoriaDao.columnNome : customControllerNome.text,
      categoriaDao.columnCor : corAtual.toString(),
    };
    final id = await dbHelperCat.insert(row);
    print('linha inserida id CATEGORIA: $id  nome '
        +customControllerNome.toString()+" cor "+corAtual);
  }

  //CHECK ERROR NULL

  String checkProblemas(){
    String erros = "";
    if (customControllerNome.text.isEmpty) {
      erros += "Insira um nome\n";
    }
    if (customControllerNome.text.length > 15) {
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




  //https://pub.dev/packages/flutter_colorpicker

  Color pickerColor = Color(4294922834);
  Color currentColor = Color(4294922834);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  createAlert(BuildContext context) {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Selecionar cor :',style: TextStyle(fontSize: 18),),
        content: SingleChildScrollView(
            child: BlockPicker(
          pickerColor: currentColor,
          onColorChanged: changeColor,
        )),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              'Ok',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onPressed: () {
              setState(() => {
                    currentColor = pickerColor,
                    corAtual = pickerColor.value.toString()
                  });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //customControllerCor.text = cor;

    return Scaffold(
      appBar: AppBar(
        title: Text('NOVA CATEGORIA'),
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
              maxLength: 15,
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
            SizedBox(
              height: 15,
            ),

            MaterialButton(
              minWidth: 500.0,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.colorize_outlined),

                  //depois deletar  //EX Color(4288423856)
                  Text("  Cor   ",style: TextStyle(
                    fontSize: 19,
                  ),)
                ],
              ),
              elevation: 1.0,
              color: currentColor,
              onPressed: () {
                createAlert(context);
              },
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
              _inserirCategoria();
              Navigator.of(context).pop();
              widget.refreshCategorias();
            } else {
              showAlertDialogErros(context);
            }

          },
          child: Icon(
            Icons.save_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
