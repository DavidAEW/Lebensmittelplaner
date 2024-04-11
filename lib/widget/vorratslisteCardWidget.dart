import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/pages/vorratsliste.dart';
import 'package:lebensmittelplaner/model/lebensmittel.dart';
import 'package:intl/intl.dart'; // for date format

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

Widget vorratslisteCardWidget(Lebensmittel lebensmittel){
  return Card(
    margin: EdgeInsets.fromLTRB(16,16,16,0),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(lebensmittel.name),
          Text(formatter.format(lebensmittel.mdh!).toString()), //Könnte Probleme machen das Ausrufezeichen!!
          Text(lebensmittel.menge as String),
        ],
      )
    )
  );
}