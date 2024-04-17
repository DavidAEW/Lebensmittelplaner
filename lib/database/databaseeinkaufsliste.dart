import 'dart:async';
import 'package:lebensmittelplaner/model/einkaufsliste.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class einkaufslisteDB {
  static final einkaufslisteDB instance = einkaufslisteDB._init();

  static Database? _database;

  einkaufslisteDB._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('einkaufsliste.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {

    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypeNull = 'TEXT';

    await db.execute('''CREATE TABLE $tableEinkaufsliste (
      ${EinkaufslisteFields.id} $idType,
      ${EinkaufslisteFields.name} $textType,
      ${EinkaufslisteFields.menge} $textTypeNull
      ) 
      '''); 
  }

  Future<Einkaufsliste> create(Einkaufsliste einkaufsliste) async {
    final db = await instance.database;

    final id = await db.insert(tableEinkaufsliste, einkaufsliste.toJson());
    return einkaufsliste.copy(id: id);
  }

  Future<List<Einkaufsliste>> read() async {
    final db = await instance.database;
    final result = await db.query(tableEinkaufsliste, orderBy: "einkaufsliste.name");

    return result.map((json) => Einkaufsliste.fromJson(json)).toList();
  }

    Future<int> update(Einkaufsliste einkaufsliste) async {
    final db = await instance.database;

    return db.update(
      tableEinkaufsliste,
      einkaufsliste.toJson(),
      where: '${EinkaufslisteFields.id} = ?',
      whereArgs: [einkaufsliste.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableEinkaufsliste,
      where: '${EinkaufslisteFields.id} =?',
      whereArgs: [id],
    );
  }

  // Future close() async {
  //   final db = await instance.database;

  //   db.close();
  // }
}