import 'dart:async';
import 'package:lebensmittelplaner/model/vorraete.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VorraeteDB {
  static final VorraeteDB instance = VorraeteDB._init();

  static Database? _database;

  VorraeteDB._init();

//Erstellt Database Instanz wenn noch keine exisitert 
//und gibt Database Instanz zurück, wenn beireits eine existiert
  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('vorraete.db');
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
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''CREATE TABLE $tableVorraete (
      ${VorratsItemFields.id} $idType,
      ${VorratsItemFields.name} $textType,
      ${VorratsItemFields.mdh} $textTypeNull,
      ${VorratsItemFields.menge} $textTypeNull,
      ${VorratsItemFields.benoetigtMdh} $boolType
      ) 
      '''); 
  }

//Datenbankeintrag wird erstellt
  Future<VorratsItem> create(VorratsItem vorraete) async {
    final db = await instance.database;

    final id = await db.insert(tableVorraete, vorraete.toJson());
    return vorraete.copy(id: id);
  }

//alle Datenbankeinträge werden gelesen
  Future<List<VorratsItem>> read() async {
    final db = await instance.database;
    final result = await db.query(
      tableVorraete, 
      orderBy: "case when vorraete.mdh is null then 1 else 0 end, vorraete.mdh"
    );

    return result.map((json) => VorratsItem.fromJson(json)).toList();
  }


//Datenbankeintrag wird geupdatet
    Future<int> update(VorratsItem vorraete) async {
    final db = await instance.database;

    return db.update(
      tableVorraete,
      vorraete.toJson(),
      where: '${VorratsItemFields.id} = ?',
      whereArgs: [vorraete.id],
    );
  }


//Datenbankeintrag wird gelöscht
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableVorraete,
      where: '${VorratsItemFields.id} =?',
      whereArgs: [id],
    );
  }
}
