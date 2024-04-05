import 'package:sqflite/sqflite.dart';
import 'package:lebensmittelplaner/database/database_service.dart';
import  'package:lebensmittelplaner/model/gegenstaende.dart';

class DieDatenbank {
  final tableName = 'gegenstaende';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName(
      "id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "haltbarkeit" TEXT NOT NULL,
      "menge" STRING NOT NULL,
      PRIMARY KEY ("id" AUTOINCREMENT)
    );""");
  }

  Future<int> create({required String name}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (name) VALUES (?)'''
    );
  }

  Future<List<Gegenstaende>> fetchAll() async {
    final database = await DatabaseService().database;
    final gegenstaende = await database.rawQuery(
      '''SELECT * FROM $tableName'''
    );
    return gegenstaende.map((gegenstaende) => Gegenstaende.fromSqfliteDatabase(gegenstaende)).toList();
  }

  Future<void> deleteById(int id) async {
    final database = await DatabaseService().database;
    final gegenstaend = await database
    .rawQuery('''Delete * FROM $tableName WHERE id = ?''', [id]);
  }
}