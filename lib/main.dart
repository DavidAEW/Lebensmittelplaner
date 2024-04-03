import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/pages/einkaufsliste.dart';
import 'package:lebensmittelplaner/pages/vorratsliste.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/Vorratsliste',
  routes: {
    '/Vorratsliste' : (context) => Vorratsliste(),
    '/Einkaufsliste': (context) => Einkaufsliste(),
  }
));
