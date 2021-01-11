import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          title: Text("Tutorial"),
          centerTitle: true,
          elevation: 3.0,
        ),

        body: ListView(
            children: <Widget>[

              Container(
                padding: EdgeInsets.fromLTRB(6,0,6,5),
                child: Text( '''    
                                 
      Aqui terá um Tutorial!!
         
          
      ''',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ]));

  }
}

