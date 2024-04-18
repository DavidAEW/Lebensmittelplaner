import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/pages/einkaufsliste_page.dart';
import 'package:lebensmittelplaner/pages/vorratslistepage.dart';

//Main Funktion in welcher der Anwendungsprozess startet. 
//Benutzer wird beim Öffnen der App immer auf die Vorratsliste geleitet
void main() => runApp(MaterialApp(
  initialRoute: '/Vorratsliste',
  routes: {
    '/Vorratsliste' : (context) => const VorratslistePage(),
    '/Einkaufsliste': (context) => const EinkaufslistePage(),
  }
));
