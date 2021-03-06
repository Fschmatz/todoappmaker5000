import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class listaDao {

  static final _databaseName = "AppMaker.db";
  static final _databaseVersion = 1;

  static final table = 'lista';
  static final columnIdLista = 'idLista';
  static final columnNome = 'nome';

  listaDao._privateConstructor();
  static final listaDao instance = listaDao._privateConstructor();
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

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdLista];
    return await db.update(table, row, where: '$columnIdLista = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnIdLista = ?', whereArgs: [id]);
  }

  //

  Future<String> retornaNomeLista(int id) async {
    Database db = await instance.database;
    //return await db.query('SELECT nome FROM $table WHERE idLista=$id').toString();


    String query = 'SELECT nome FROM $table WHERE idLista=$id';
    var dbQuery = await db.rawQuery(query);
    String nome = dbQuery.first.values.first.toString();
    return nome;

    //return await db.rawQuery('''SELECT nome FROM $table WHERE idLista=$id''');
  }
}