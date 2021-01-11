import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class categoriaDao {

  static final _databaseName = "AppMaker.db";
  static final _databaseVersion = 2;

  static final table = 'categoria';
  static final columnIdCategoria = 'idCategoria';
  static final columnNome = 'nome';
  static final columnCor = 'cor';

  categoriaDao._privateConstructor();
  static final categoriaDao instance = categoriaDao._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

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

  Future<List<Map<String, dynamic>>> queryAllOrganizado() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table ORDER BY $columnNome');
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdCategoria];
    return await db.update(table, row, where: '$columnIdCategoria = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> retornaCategoriasNessaLista(int lista) async {
    Database db = await instance.database;
    return await db.rawQuery('''
    
        SELECT idCategoria
        FROM task 
        WHERE idLista=$lista 
        GROUP BY idCategoria  
        
        ''');
  }

  Future<List<Map<String, dynamic>>> retornaCategoriasNessaListaEstado(int lista,int estado) async {
    Database db = await instance.database;
    return await db.rawQuery('''
    
        SELECT idCategoria
        FROM task 
        WHERE idLista=$lista AND estado=$estado
        GROUP BY idCategoria  
        
        ''');
  }

  Future<List<Map<String, dynamic>>> retornaCategoriasPorId(int id) async {
    Database db = await instance.database;
    return await db.rawQuery('''
    
        SELECT * 
        FROM categoria 
        WHERE idCategoria=$id          
        
        ''');
  }

  Future<List<Map<String, dynamic>>> retornaNomeCorPorId(int id) async {
    Database db = await instance.database;
    return await db.rawQuery('''
    
        SELECT nome,cor 
        FROM categoria 
        WHERE idCategoria=$id          
        
        ''');
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnIdCategoria = ?', whereArgs: [id]);
  }
}