import 'package:flutter/material.dart';
import 'package:todoappmaker5000/dao/categoriaDao.dart';
import 'package:todoappmaker5000/ui/cardTasks.dart';
import 'package:todoappmaker5000/dao/taskDao.dart';

class containerCategoria extends StatefulWidget {
  @override
  _containerCategoriaState createState() => _containerCategoriaState();

  int idCategoria;
  int estado;
  Function() refreshListaHome;

  containerCategoria({Key key, this.idCategoria, this.estado, this.refreshListaHome})
      : super(key: key);
}

class _containerCategoriaState extends State<containerCategoria> {
  final dbHelperTask = taskDao.instance;
  final dbHelperCat = categoriaDao.instance;

  List<Map<String, dynamic>> listaTasks = [];
  List<Map<String, dynamic>> listaCategoria = [];


  @override
  void initState() {
    getAllCategoriasTasks();
    super.initState();
  }

  Future<void> getAllCategoriasTasks() async {
    var respostaTasks = await dbHelperTask.retornaTasksCategoriaIdCorNaLista(
        1, widget.idCategoria, widget.estado);

    var respostaCategoria =
    await dbHelperCat.retornaNomeCorPorId(widget.idCategoria);
    setState(() {
      listaTasks = respostaTasks;
      listaCategoria = respostaCategoria;
    });
  }

  /*Future<void> getNomeCorCategoria() async {
    var respostaCategoria =
    await dbHelperCat.retornaNomeCorPorId(widget.idCategoria);
    setState(() {
      listaCategoria = respostaCategoria;
    });
  }

  // POR ENQUANTO LISTA 1
  Future<void> getTasksListaCategoria() async {
    var respostaTasks = await dbHelperTask.retornaTasksCategoriaIdCorNaLista(
        1, widget.idCategoria,widget.estado);
    setState(() {
      listaTasks = respostaTasks;
    });
  }*/

  Future refreshListaCatTask() {
    setState(() {
      getAllCategoriasTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TOPO DA CATEGORIA + CONTAGEM
        ListTile(
          trailing: Text(listaTasks.length.toString(),
              style: TextStyle(fontSize: 18)),
          title: Text(
            listaCategoria[0]['nome'].toUpperCase(), //
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),

        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16), topLeft: Radius.circular(16)),
          child: Card(
            elevation: 3.0,
            child: Container(
              //DETALHE COM A COR
              //margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                foregroundDecoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: Color(int.parse(listaCategoria[0]['cor'])),
                          width: 4.0)),
                ),
                child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(thickness: 1.3,height: 0,),
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          //padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                          itemCount: listaTasks.length,
                          itemBuilder: (context, int index) {
                            return Container(
                              //padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                              child: CardTasks(
                                nome: listaTasks[index]['nome'],
                                nota: listaTasks[index]['nota'],
                                id: listaTasks[index]['idTask'],
                                estado: listaTasks[index]['estado'] == 1
                                    ? false
                                    : true,
                                exibirExcluir: listaTasks[index]['estado'] == 1
                                    ? false
                                    : true,
                                refreshCatTasks: refreshListaCatTask,
                                refreshHome: widget.refreshListaHome,
                              ),
                            );
                          },
                        ),

            ),
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
