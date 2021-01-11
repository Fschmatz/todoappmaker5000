import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoappmaker5000/dao/taskDao.dart';

class CardTasks extends StatefulWidget {
  @override
  _CardTasksState createState() => _CardTasksState();

  String nome;
  String nota;
  int id;
  bool estado;
  Function() refreshCatTasks;
  Function() refreshHome;
  Function() refreshListaCompletas;
  bool exibirExcluir;
  CardTasks({Key key, this.nome, this.nota,
    this.id, this.estado,this.refreshCatTasks,
    this.refreshHome, this.exibirExcluir, this.refreshListaCompletas
  }) : super(key: key);
}


class _CardTasksState extends State<CardTasks> {

  void _deletar(int id) async {
    final dbTask = taskDao.instance;
    final linhaDeletada = await dbTask.delete(id);
    print('Deletado TASK com ID= $id');
  }

  void atualizarEstado(int id, int estado) async {
    final dbTask = taskDao.instance;
    Map<String, dynamic> row = {
      taskDao.columnIdTask : id,
      taskDao.columnEstado : estado,
    };
    final linhasAfetadas = await dbTask.updateEstado(row);
    print('atualizadas $linhasAfetadas linha(s)');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 0.0,

        child: ListTile(
          dense: widget.nota.isEmpty && widget.nome.length < 25  ? true : false,
          isThreeLine: widget.nota.length > 40  || widget.nome.length > 50  ? true : false,
          title: Text(
            widget.nome,
            style: TextStyle(fontSize: 17),
          ),
          subtitle:Text(
            widget.nota,
            style: TextStyle(fontSize: 16),
          ),


          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Visibility(
                visible: widget.exibirExcluir,
                child: IconButton(
                  iconSize: 27,
                  icon: Icon(
                    Icons.delete_outline,
                  ),
                  onPressed: () {
                    _deletar(widget.id);
                    widget.refreshCatTasks();
                  },
                ),
              ),

              Checkbox(
                activeColor: Color(0xFF0272AF),
                value: widget.estado,
                onChanged: (bool v) {
                  setState(() {
                    if(widget.estado){
                      atualizarEstado(widget.id, 1);
                    }else{
                      atualizarEstado(widget.id, 0);
                    }

                    if(widget.exibirExcluir){
                      widget.refreshHome();
                    }

                    widget.refreshCatTasks();

                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


