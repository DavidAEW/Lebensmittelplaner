import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:lebensmittelplaner/database/databasevorraete.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';

class MdhHinzufuegenPage extends StatefulWidget {

  final List<Vorraete> mdhHinzufuegenListe;
  
  const MdhHinzufuegenPage({Key? key, required this.mdhHinzufuegenListe}) : super(key: key);

  @override
  State<MdhHinzufuegenPage> createState() => _MdhHinzufuegenPageState();
}

class _MdhHinzufuegenPageState extends State<MdhHinzufuegenPage> {
  DateTime heutigesDatum = DateTime.now();
  DateTime? ausgewaehlteDateTime;

      Future EditVorraete(int? id, String name, DateTime? mdh, String? menge) async {

      final vorraete = Vorraete(
        id: id,
        name: name,
        mdh: mdh,
        menge: menge,
        benoetigtMdh: false,
      );
      
      await meineDatenbank.instance.update(vorraete);

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center( child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.mdhHinzufuegenListe[0].name),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: heutigesDatum,
                onDateTimeChanged: (DateTime newDateTime) {
                  log(newDateTime.toString());
                  ausgewaehlteDateTime = newDateTime;
                },
              ),
            ),
          ]
        ),
      ),
      persistentFooterButtons: [
        TextButton(
          child: Text("Nächster Gegenstand"),
          onPressed: () {
            EditVorraete(
              widget.mdhHinzufuegenListe[0].id,
              widget.mdhHinzufuegenListe[0].name,
              ausgewaehlteDateTime,
              widget.mdhHinzufuegenListe[0].menge 
            ); 
            widget.mdhHinzufuegenListe.removeAt(0);
            if(widget.mdhHinzufuegenListe.isNotEmpty){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MdhHinzufuegenPage(mdhHinzufuegenListe: widget.mdhHinzufuegenListe)),
              );
            } else {
              Navigator.pop(context);
            }
          }
        ),
      ],
    );
  }
}