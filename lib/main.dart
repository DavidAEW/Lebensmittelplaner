import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/pages/einkaufslistepage.dart';
import 'package:lebensmittelplaner/pages/vorratslistepage.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/Vorratsliste',
    routes: {
      '/Vorratsliste' : (context) => VorratslistePage(),
      '/Einkaufsliste': (context) => EinkaufslistePage(),
    }
));