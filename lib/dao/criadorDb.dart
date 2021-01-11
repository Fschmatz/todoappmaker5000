import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class criadorDB {

  static final _databaseName = "AppMaker.db";
  static final _databaseVersion = 1;

  criadorDB._privateConstructor(); //_privateConstructor
  static final criadorDB instance = criadorDB._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  initDatabase() async { //_initDatabase();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    print("OI DO CRIADOR DE DB");

    await db.execute('''
          CREATE TABLE categoria (
          
            idCategoria INTEGER PRIMARY KEY,
            nome TEXT NOT NULL,            
            cor TEXT NOT NULL
                      
          )
          ''');

    await db.execute('''
          CREATE TABLE lista (
          
            idLista INTEGER PRIMARY KEY,
            nome TEXT NOT NULL
                      
          )
          ''');

    await db.execute('''
          CREATE TABLE task (
          
            idTask INTEGER PRIMARY KEY,
            nome TEXT NOT NULL, 
            estado INTEGER NOT NULL,            
            nota TEXT,
            idLista INTEGER NOT NULL, 
            idCategoria INTEGER NOT NULL,
            FOREIGN KEY (idLista) REFERENCES lista (_idLista),
            FOREIGN KEY (IdCategoria) REFERENCES categoria (_idCategoria)
                                  
          )
          ''');

    Batch batch = db.batch();
    batch.insert('lista', {'nome': 'MyNewApp'});
    //batch.insert('categoria', {'idCategoria': 999,'nome': 'Sem Categoria','cor': '4284513675'});
    //batch.insert('categoria', {'nome': 'Sem Categoria','cor': '4284513675'});
    await batch.commit(noResult: true);

  }

}