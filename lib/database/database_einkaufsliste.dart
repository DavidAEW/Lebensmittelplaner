import 'dart:async';
import 'package:lebensmittelplaner/model/einkaufsliste.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EinkaufslisteDB {
  static final EinkaufslisteDB instance = EinkaufslisteDB._init();
  static Database? _database;

  EinkaufslisteDB._init();

//Erstellt Database Instanz wenn noch keine exisitert 
//und gibt Database Instanz zurück, wenn beireits eine existiert
  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('einkaufsliste.db');
    return _database!;
  }

//Erstellt Datenbankschema, wenn noch keins unter dem Namen exisitert
// und gibt Datenbankschema zurück, wenn ein bereits exisitert.
  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

//Datenbankschema wird erstellt
  Future _createDB(Database db, int version) async {

    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypeNull = 'TEXT';

    await db.execute('''CREATE TABLE $tableEinkaufsliste (
      ${EinkaufslisteItemFields.id} $idType,
      ${EinkaufslisteItemFields.name} $textType,
      ${EinkaufslisteItemFields.menge} $textTypeNull
      ) 
      '''); 
  }

//Datenbankeintrag wird erstellt
  Future<EinkaufslisteItem> create(EinkaufslisteItem einkaufsliste) async {
    final db = await instance.database;

    final id = await db.insert(tableEinkaufsliste, einkaufsliste.toJson());
    return einkaufsliste.copy(id: id);
  }

//alle Datenbankeinträge werden gelesen
  Future<List<EinkaufslisteItem>> read() async {
    final db = await instance.database;
    final result = await db.query(tableEinkaufsliste, orderBy: "einkaufsliste.name");

    return result.map((json) => EinkaufslisteItem.fromJson(json)).toList();
  }

//Datenbankeintrag wird geupdatet
    Future<int> update(EinkaufslisteItem einkaufsliste) async {
    final db = await instance.database;

    return db.update(
      tableEinkaufsliste,
      einkaufsliste.toJson(),
      where: '${EinkaufslisteItemFields.id} = ?',
      whereArgs: [einkaufsliste.id],
    );
  }

//Datenbankeintrag wird gelöscht
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableEinkaufsliste,
      where: '${EinkaufslisteItemFields.id} =?',
      whereArgs: [id],
    );
  }
}