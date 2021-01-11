import 'package:flutter/material.dart';
import 'package:todoappmaker5000/dao/categoriaDao.dart';
import 'package:todoappmaker5000/ui/dialogNovaCategoria.dart';

class listSelectCategoria extends StatefulWidget {
  @override
  _listSelectCategoriaState createState() => _listSelectCategoriaState();

  Function(String,String,int) setCategoria;
  listSelectCategoria({Key key, this.setCategoria}) : super(key: key);
}

class _listSelectCategoriaState extends State<listSelectCategoria> {
  final dbHelperCat = categoriaDao.instance;
  //List<Map<String, dynamic>> listaCategorias;


  @override
  void initState() {
    super.initState();
    getAllCategorias();
  }

  List<Map<String, dynamic>> listaCategorias = [];

  Future<void> getAllCategorias() async {
    var resposta = await dbHelperCat.queryAllOrganizado();
    setState(() {
      listaCategorias = resposta;
    });
  }

  Future refreshLista() {
    setState(() {
      getAllCategorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SELECIONAR CATEGORIA'),
          actions: <Widget>[
             Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          dialogNovaCategoria(refreshCategorias: refreshLista,),
                      fullscreenDialog: true,
                    ),
                  );

                },
                child: Icon(
                  Icons.add,
                  size: 26.0,
                ),
              ),
            ),
          ],
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //ITENS
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  itemCount: listaCategorias.length,
                  itemBuilder: (context, int index) {
                    return Card(
                      elevation: 3.0,
                      margin: const EdgeInsets.all(7.0),
                      child: ListTile(
                        title: Text(
                          listaCategorias[index]['nome'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        leading:Icon(
                          Icons.circle,
                          size:36,
                          color: Color(int.parse(listaCategorias[index]['cor'])),
                        ),
                        onTap: (){
                          Navigator.of(context).pop();
                          //AJEITAR MAIS TARDE POR QUESTÃO DE TESTE ID VAI JUNTO
                          widget.setCategoria(
                            listaCategorias[index]['nome'],
                            listaCategorias[index]['cor'],
                            listaCategorias[index]['idCategoria'],
                          );

                        },
                      ),
                    );
                  },
                ),
              ),
              //SizedBox(height: 250,)
            ]));
  }
}

