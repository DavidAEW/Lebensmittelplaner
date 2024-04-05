import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/pages/einkaufsliste.dart';
import 'package:lebensmittelplaner/pages/vorratsliste.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {

  sqfliteFfiInit();


 databaseFactory = databaseFactoryFfi;
 
  runApp(MaterialApp(
    initialRoute: '/Vorratsliste',
    routes: {
     '/Vorratsliste' : (context) => const Vorratsliste(),
     '/Einkaufsliste': (context) => const Einkaufsliste(),
   }
  ));
}
