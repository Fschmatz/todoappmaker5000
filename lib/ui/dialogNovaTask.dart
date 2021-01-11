import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../ui/listSelectCategoria.dart';
import '../dao/taskDao.dart';

class dialogNovaTask extends StatefulWidget {
  @override
  _dialogNovaTaskState createState() => _dialogNovaTaskState();

  Function() refreshTasks;
  dialogNovaTask({Key key, this.refreshTasks}) : super(key: key);
}

class _dialogNovaTaskState extends State<dialogNovaTask> {
  TextEditingController customControllerTarefa = TextEditingController();
  TextEditingController customControllerNota = TextEditingController();
  TextEditingController customControllerCategoria = TextEditingController();

  final dbHelperLista = taskDao.instance;
  Color corIconCat;
  int idCategoria;
  String categoriaEscolhida = "";
  FocusNode inputFieldNode;

  @override
  void initState() {
    super.initState();
  }

  //ESTADO INICIAL SEMPRE 1
  void _inserirTask() async {
    Map<String, dynamic> row = {
      taskDao.columnNome: customControllerTarefa.text,
      taskDao.columnEstado: 1,
      taskDao.columnNota: customControllerNota.text,
      taskDao.columnIdCategoria: idCategoria,
      taskDao.columnIdLista: 1
    };
    final id = await dbHelperLista.insert(row);
    print('linha inserida id LISTA: $id');
  }


  //DEPOIS remover ID do texto,

  void setCategoriaTask(String x,String cor,int id) {
    setState(() => categoriaEscolhida = x);
    customControllerCategoria.text = categoriaEscolhida;
    corIconCat = Color(int.parse(cor));
    idCategoria = id;
  }

  String checkProblemas(){
    String erros = "";
    if (customControllerTarefa.text.isEmpty) {
      erros += "Insira um nome\n";
    }
    if (customControllerCategoria.text.isEmpty) {
      erros += "Escolha uma categoria\n";
    }
    if (customControllerTarefa.text.length > 50) {
      erros += "Nome muito extenso\n";
    }
    if (customControllerNota.text.length > 75) {
      erros += "Nota muito extensa";
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
    final node = FocusScope.of(context);

    return  Scaffold(
      appBar: AppBar(
        title: Text('NOVA TAREFA'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),

        child:
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15,
            ),

            TextField(
              minLines: 1,
              maxLines: 2,
              maxLength: 50,
              maxLengthEnforced: true,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
              controller: customControllerTarefa,
              autofocus: true,
              onEditingComplete: () => node.nextFocus(),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.library_add_check_outlined),
                  hintText: "Tarefa",
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

            //NOTA

            TextField(
              minLines: 1,
              maxLines: 2,
              maxLength: 75,
              maxLengthEnforced: true,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
              controller: customControllerNota,
              autofocus: true,
              //onEditingComplete: () => node.nextFocus(),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.article),
                  hintText: "Nota",
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




            //CATEGORIA
            TextField(
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        listSelectCategoria(setCategoria: setCategoriaTask,),
                    fullscreenDialog: true,
                  ),
                );

              },
              minLines: 1,
              maxLines: 2,
              readOnly: true,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
              controller: customControllerCategoria,
              //onEditingComplete: () {},
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.circle,color: corIconCat,size: 28,),
                  //prefixIcon: Icon(Icons.list_alt,color: corIconCat,),
                  hintText: "Categoria",
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
              _inserirTask();
              widget.refreshTasks();
              Navigator.of(context).pop();
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

