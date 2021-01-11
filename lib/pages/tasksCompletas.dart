import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoappmaker5000/dao/categoriaDao.dart';
import 'package:todoappmaker5000/ui/containerCategoria.dart';

class tasksCompletas extends StatefulWidget {
  @override
  _tasksCompletasState createState() => _tasksCompletasState();

  int listaAtual;
  Function() refreshListaHome;

  tasksCompletas({Key key, this.listaAtual,this.refreshListaHome}) : super(key: key);
}

class _tasksCompletasState extends State<tasksCompletas> {
  @override
  void initState() {
    getAllCategoriasNaLista();
    super.initState();
  }

  final dbHelperCategoria = categoriaDao.instance;

  List<Map<String, dynamic>> listaCategorias = [];

  Future<void> getAllCategoriasNaLista() async {
    //await dbHelperCategoria.retornaCategoriasNessaLista(widget.listaAtual);
    var resposta = await dbHelperCategoria.retornaCategoriasNessaListaEstado(widget.listaAtual,0);
    setState(() {
      listaCategorias = resposta;
    });
  }

  /*Future refreshListaCompletas() {
    setState(() {
      getAllCategoriasNaLista();
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("TAREFAS COMPLETAS"),
        elevation: 3.0,
      ),
      body: ListView(children: <Widget>[

        ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  itemCount: listaCategorias.length,
                  itemBuilder: (context, int index) {
                    return containerCategoria(
                      idCategoria: listaCategorias[index]['idCategoria'],
                      estado: 0,
                      refreshListaHome: widget.refreshListaHome,
                    );
                  },
                ), //;


      ]),
    );
  }
}
