import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class taskDao {

  static final _databaseName = "AppMaker.db";
  static final _databaseVersion = 3;

  static final table = 'task';
  static final columnIdTask = 'idTask';
  static final columnNome = 'nome';
  static final columnEstado = 'estado';
  static final columnNota = 'nota';
  static final columnIdLista = 'idLista';
  static final columnIdCategoria = 'idCategoria';

  taskDao._privateConstructor();
  static final taskDao instance = taskDao._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdTask];
    return await db.update(table, row, where: '$columnIdTask = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnIdTask = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> retornaTasksNaLista(int lista) async {
    Database db = await instance.database;
    return await db.rawQuery('''
    
        SELECT * FROM $table WHERE idLista=$lista     
        
        ''');
  }

  // ESTADO 1 = PARA FAZER     0=DONE
  Future<List<Map<String, dynamic>>> retornaTasksCategoriaIdCorNaLista(int lista,int categoria,int estado) async {
    Database db = await instance.database;
    return await db.rawQuery('''
    
        SELECT t.idTask,t.nome,t.nota,t.estado,t.idCategoria,c.cor
        FROM task t JOIN categoria c 
        WHERE t.idLista=$lista AND t.idCategoria=c.idCategoria 
              AND t.idCategoria=$categoria AND t.estado=$estado
        GROUP BY t.idTask 
        ORDER BY c.idCategoria    
        
        ''');
  }


  Future<List<Map<String, dynamic>>> retornaTasksNaCategoria(int categoria) async {
    Database db = await instance.database;
    return await db.rawQuery('''
    
        SELECT * FROM $table 
        WHERE idCategoria=$categoria     
        
        ''');
  }

  Future<List<Map<String, dynamic>>> retornaTasksNaCategoriaLista(int lista, int categoria) async {
    Database db = await instance.database;
    return await db.rawQuery('''
    
        SELECT * FROM $table 
        WHERE idCategoria=$categoria AND idLista=$lista    
        
        ''');
  }

  Future<int> updateEstado(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdTask];
    return await db.update(table, row, where: '$columnIdTask = ?', whereArgs: [id]);
  }
}