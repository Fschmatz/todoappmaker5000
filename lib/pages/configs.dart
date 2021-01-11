import 'package:flutter/material.dart';
import 'package:todoappmaker5000/ui/dialogNovaCategoria.dart';
import 'package:todoappmaker5000/ui/dialogNovaLista.dart';
import 'package:todoappmaker5000/util/theme.dart';
import '../util/versaoNomeChangelog.dart';
import 'package:provider/provider.dart';

class Configs extends StatefulWidget {
  @override
  _ConfigsState createState() => _ConfigsState();

  Configs({Key key}) : super(key: key);
}

class _ConfigsState extends State<Configs> {
  @override
  void initState() {
    super.initState();
  }

  void showAlertDialogNovaLista(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogNovaLista();
      },
    );
  }

  /*void showAlertDialogNovaCategoria(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogNovaCategoria();
      },
    );
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text("Configurações"),
          centerTitle: true,
          elevation: 3.0,
        ),

        body: Stack(
        children: <Widget>[
        SingleChildScrollView(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 3.0,
                margin: const EdgeInsets.all(2.0),
                color: Colors.yellow,
                child: ListTile(
                  title: Text(
                    "Flutter " +
                        versaoNomeChangelog.nomeApp +
                        " " +
                        versaoNomeChangelog.versaoApp,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),

                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Opções: ",
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(
                height: 15.0,
              ),

              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  "Tema Escuro",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => Switch(
                      activeColor: Colors.blue,
                      value: notifier.darkTheme,
                      onChanged: (value) {
                        notifier.toggleTheme();
                      }),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 15.0,
              ),



              Text(
                "Adicionar: ",
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(
                height: 15.0,
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  "Nova Categoria",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.add),
                onTap: (){
                  //showAlertDialogNovaCategoria(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => dialogNovaCategoria(),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),


              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  "Nova Lista",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.add),
                onTap: (){

                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                      builder: (BuildContext context) => dialogNovaLista(),
                  fullscreenDialog: true,
                  ));


                },
              ),
              Divider(
                thickness: 1,
              ),

              SizedBox(
                height: 15.0,
              ),

              Text(
                "Gerenciamento: ",
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(
                height: 15.0,
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  "Editar / Deletar Categorias",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.edit_outlined),
              ),


              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  "Editar / Deletar  Listas",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.edit_outlined),
              ),
              Divider(
                thickness: 1,
              ),

            ],
          ),
        )
      ],
    ));
  }
}
