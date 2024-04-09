import 'dart:async';

import 'package:flutter/services.dart';
import 'package:lebensmittelplaner/model/lebensmittel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class meineDatenbank {
  static final meineDatenbank instance = meineDatenbank._init();

  static Database? _database;

  meineDatenbank._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('lebensmittel.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {

    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tableLebensmittel (
      ${LebensmittelFields.id} $idType,
      ${LebensmittelFields.name} $textType,
      ${LebensmittelFields.mdh} $textType,
      ${LebensmittelFields.menge} $textType
      ) 
      '''); 
  }

  Future<Lebensmittel> create(Lebensmittel lebensmittel) async {
    final db = await instance.database;

    final id = await db.insert(tableLebensmittel, lebensmittel.toJson());
    return lebensmittel.copy(id: id);
  }

  Future<List<Lebensmittel>> read() async {
    final db = await instance.database;
    final result = await db.query(tableLebensmittel);

    return result.map((json) => Lebensmittel.fromJson(json)).toList();
  }

    Future<int> update(Lebensmittel lebensmittel) async {
    final db = await instance.database;

    return db.update(
      tableLebensmittel,
      lebensmittel.toJson(),
      where: '${LebensmittelFields.id} = ?',
      whereArgs: [lebensmittel.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableLebensmittel,
      where: '${LebensmittelFields.id} =?',
      whereArgs: [id],
    );
  }

  // Future close() async {
  //   final db = await instance.database;

  //   db.close();
  // }
}
