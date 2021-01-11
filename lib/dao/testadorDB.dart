import 'package:flutter/material.dart';
import 'package:todoappmaker5000/dao/categoriaDao.dart';
import 'package:todoappmaker5000/dao/listaDao.dart';
import '../dao/taskDao.dart';

class TestadorDB extends StatefulWidget {
  @override
  _TestadorDB createState() => _TestadorDB();
}

class _TestadorDB extends State<TestadorDB> {
  // referencia nossa classe single para gerenciar o banco de dados
  final dbHelperTask = taskDao.instance;
  final dbHelperCat = categoriaDao.instance;
  final dbHelperLista = listaDao.instance;

  // layout da homepage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              elevation: 0.0,
              margin: const EdgeInsets.all(10.0),
              color: Colors.deepPurple[200],
              child: ListTile(
                title: Text(
                  "Testador Banco de Dados",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                //leading: Icon(Icons.settings_outlined),
              ),
            ),

            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                elevation: 0.0,
                margin: const EdgeInsets.fromLTRB(10, 1, 10, 10),
                color: Colors.red[600],
                child: Column(children: <Widget>[
                  ListTile(
                    title: Text(
                      "->   ENTRADAS HARDCODED   <-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        //color: Colors.white
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "->   SAIDAS NO CONSOLE   <-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        //color: Colors.white
                      ),
                    ),
                  ),
                ])),


            Card(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    tileColor: Colors.blue[700],
                    title: Text(
                      "->   TASKS   <-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        //color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                    color: Colors.grey[600],
                    child: Text(
                      'ALL FROM LISTA ID = 1',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _queryTodosListaUM();
                    },
                  ),
                  RaisedButton(
                    color: Colors.grey[600],
                    child: Text(
                      'ALL FROM CATEGORIA ID = 1',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _queryTodosCategoriaUM();
                    },
                  ),
                  RaisedButton(
                    color: Colors.grey[600],
                    child: Text(
                      'INSERIR',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _inserirTask();
                    },
                  ),
                  RaisedButton(
                    color: Colors.grey[600],
                    child: Text(
                      'CONSULTAR TODOS',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _consultarTask();
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),



            Card(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    tileColor: Colors.teal,
                    title: Text(
                      "->   TESTES VARIADOS   <-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        //color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                    color: Colors.grey[600],
                    child: Text(
                      'NOME LISTA ID=1',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _nomeLista();
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),



            //LISTA
            Card(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    tileColor: Colors.blue[700],
                    title: Text(
                      "->   LISTA   <-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        //color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                    color: Colors.grey[600],
                    child: Text(
                      'CONSULTAR TODOS',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _consultarLista();
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),

            //CATEGORIA

            Card(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    tileColor: Colors.blue[700],
                    title: Text(
                      "->   CATEGORIA   <-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        //color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                    color: Colors.grey[600],
                    child: Text(
                      'CONSULTAR TODOS',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _consultarCategoria();
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //TASKS
  // métodos dos Buttons
  void _inserirTask() async {
    // linha para incluir
    Map<String, dynamic> row = {
      taskDao.columnNome: 'Finalizar temas',
      taskDao.columnNota: '',
      taskDao.columnEstado: 0,
      taskDao.columnIdLista: 1, // POR ENQUANTO SÓ LISTA 1
      taskDao.columnIdCategoria: 1,
    };
    final id = await dbHelperTask.insert(row);
    print('linha inserida id em TASK: $id');
  }

  void _consultarTask() async {
    final todasLinhas = await dbHelperTask.queryAllRows();
    print('Consulta todas as linhas TASK:');
    todasLinhas.forEach((row) => print(row));
  }

  void _queryTodosListaUM() async {
    final todasLinhas = await dbHelperTask.retornaTasksNaLista(1);
    print('TASKS DA LISTA 1:');
    todasLinhas.forEach((row) => print(row));
  }

  void _queryTodosCategoriaUM() async {
    final todasLinhas = await dbHelperTask.retornaTasksNaCategoria(1);
    print('TASKS DA CATEGORIA 1:');
    todasLinhas.forEach((row) => print(row));
  }

  //CATEGORIAS
  void _consultarCategoria() async {
    final todasLinhas = await dbHelperCat.queryAllRows();
    print('Consulta todas as linhas CATEGORIA :');
    todasLinhas.forEach((row) => print(row));
  }

  //LISTA
  void _consultarLista() async {
    final todasLinhas = await dbHelperLista.queryAllRows();
    print('Consulta todas as linhas LISTA:');
    todasLinhas.forEach((row) => print(row));
  }

  void _nomeLista() async {
    final nome = await dbHelperLista.retornaNomeLista(1);
    print('NOME LISTA:');
   print(nome);
  }
}
