import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoappmaker5000/dao/categoriaDao.dart';
import 'package:todoappmaker5000/dao/testadorDB.dart';
import 'package:todoappmaker5000/pages/about.dart';
import 'package:todoappmaker5000/pages/changelog.dart';
import 'package:todoappmaker5000/pages/configs.dart';
import 'package:todoappmaker5000/pages/tasksCompletas.dart';
import 'package:todoappmaker5000/ui/containerCategoria.dart';
import 'package:todoappmaker5000/ui/dialogNovaTask.dart';
import '../util/versaoNomeChangelog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  int listaAtual;

  Home({Key key, this.listaAtual}) : super(key: key);
}

class _HomeState extends State<Home> {


  @override
  void initState() {
    getAllCategoriasNaLista();
    super.initState();
    //setNomeLista();
    //getAllCategoriasNaLista();
  }

  final dbHelperCategoria = categoriaDao.instance;
  List<Map<String, dynamic>> listaCategorias = [];

  /*List<Map<String, dynamic>> listaCategorias =
      List<Map<String, dynamic>>.empty(growable: true);*/

  //final dbHelperTask = taskDao.instance;
  //final dbHelperLista = listaDao.instance;
  //List<Map<String, dynamic>> listaTasks = []; //= new List();
  //String nomeLista;

  //Future<void>
  Future<void> getAllCategoriasNaLista() async {
    //await dbHelperCategoria.retornaCategoriasNessaLista(widget.listaAtual);
    var resposta = await dbHelperCategoria.retornaCategoriasNessaListaEstado(widget.listaAtual,1);
    setState(() {
      listaCategorias = resposta;
    });
  }

  /*Future<void> setNomeLista() async {
    var resposta = await dbHelperLista.retornaNomeLista(widget.listaAtual);
    setState(() {
      nomeLista = resposta;
    });
  }*/

  refreshListaHome() {
    setState(() {
      getAllCategoriasNaLista();
    });
  }

  //BOTTOM MENU
  void bottomMenu(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                //TOPO

                Card(
                  //elevation: 3.0,
                  margin: EdgeInsets.fromLTRB(50, 15, 50, 20),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[700], width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(
                      versaoNomeChangelog.nomeApp +
                          " " +
                          versaoNomeChangelog.versaoApp,
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                //TESTADOR DB DELETAR MAIS TARDE
                /* ListTile(
                  leading: Icon(
                    Icons.adb_outlined,
                    color: Colors.redAccent,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(
                    "TestadorDB",
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => TestadorDB(),
                          fullscreenDialog: true,
                        ));
                  },
                ),
                Divider(
                  thickness: 1,
                ),*/

                ListTile(
                  leading: Icon(Icons.check_box_outlined),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(
                    "Tarefas Completas",
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => tasksCompletas(
                            listaAtual: 1,
                            refreshListaHome: refreshListaHome,
                          ),
                          fullscreenDialog: true,
                        ));
                  },
                ),
                Divider(
                  thickness: 1,
                ),

                ListTile(
                  leading: Icon(Icons.settings_outlined),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(
                    "Configurações",
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Configs(),
                          fullscreenDialog: true,
                        ));
                  },
                ),
                Divider(
                  thickness: 1,
                ),

                ListTile(
                  leading: Icon(Icons.text_snippet_outlined),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(
                    "Changelog",
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Changelog(),
                          fullscreenDialog: true,
                        ));
                  },
                ),
                Divider(
                  thickness: 1,
                ),

                ListTile(
                  leading: Icon(Icons.text_snippet_outlined),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(
                    "Sobre",
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => About(),
                          fullscreenDialog: true,
                        ));
                  },
                ),

                /* Divider(
                  thickness: 1,
                ),

                //DELETAR?
                ListTile(
                  leading: Icon(Icons.text_snippet_outlined),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(
                    "Tutorial",
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Tutorial(),
                          fullscreenDialog: true,
                        ));
                  },
                ),*/
                SizedBox(height: 65)
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Container(
                  //trailing: Icon(Icons.more_vert_outlined),
                  alignment: Alignment.center,
                  child: Text(
                    "TodoAppMaker5000", //.toUpperCase()
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ]),

          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            itemCount: listaCategorias.length,
            itemBuilder: (context, int index) {

              return containerCategoria(
                idCategoria: listaCategorias[index]['idCategoria'],
                estado: 1,
                refreshListaHome: refreshListaHome,
                key: UniqueKey(), //USADO pro REFRESH GERAL
              );
            },




          ),

          SizedBox(
            height: 40,
          )
        ]),

        //BOTTOMBAR
        floatingActionButton: Container(
          child: FittedBox(
            child: FloatingActionButton(
              elevation: 5.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => dialogNovaTask(
                      refreshTasks: refreshListaHome,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 50,
              child: Row(
                //mainAxisSize: MainAxisSize.max,
                //mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        icon: Icon(
                          Icons.menu,
                          size: 27,
                        ),
                        onPressed: () {
                          bottomMenu(context);
                        }),
                  ])),
        ));
  }
}

