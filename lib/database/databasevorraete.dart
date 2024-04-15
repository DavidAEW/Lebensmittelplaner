import 'dart:async';
import 'package:flutter/services.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class meineDatenbank {
  static final meineDatenbank instance = meineDatenbank._init();

  static Database? _database;

  meineDatenbank._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('vorraete.db');
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
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''CREATE TABLE $tableVorraete (
      ${VorraeteFields.id} $idType,
      ${VorraeteFields.name} $textType,
      ${VorraeteFields.mdh} $textTypeNull,
      ${VorraeteFields.menge} $textTypeNull,
      ${VorraeteFields.benoetigtMdh} $boolType
      ) 
      '''); 
  }

  Future<Vorraete> create(Vorraete vorraete) async {
    final db = await instance.database;

    final id = await db.insert(tableVorraete, vorraete.toJson());
    return vorraete.copy(id: id);
  }

  Future<List<Vorraete>> read() async {
    final db = await instance.database;
    final result = await db.query(
      tableVorraete, 
      orderBy: "case when vorraete.mdh is null then 1 else 0 end, vorraete.mdh"
    );

    return result.map((json) => Vorraete.fromJson(json)).toList();
  }

    Future<int> update(Vorraete vorraete) async {
    final db = await instance.database;

    return db.update(
      tableVorraete,
      vorraete.toJson(),
      where: '${VorraeteFields.id} = ?',
      whereArgs: [vorraete.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableVorraete,
      where: '${VorraeteFields.id} =?',
      whereArgs: [id],
    );
  }

  // Future close() async {
  //   final db = await instance.database;

  //   db.close();
  // }
}
