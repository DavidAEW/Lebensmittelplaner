import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:lebensmittelplaner/database/database_vorratsliste.dart';
import 'package:flutter/cupertino.dart';

class MdhHinzufuegenPage extends StatefulWidget {

  final List<VorratsItem> mdhHinzufuegenListe;
  const MdhHinzufuegenPage({super.key, required this.mdhHinzufuegenListe});

  @override
  State<MdhHinzufuegenPage> createState() => _MdhHinzufuegenPageState();
}

class _MdhHinzufuegenPageState extends State<MdhHinzufuegenPage> {
  DateTime heutigesDatum = DateTime.now();
  DateTime? ausgewaehltesDatum;

//Vorratsgegenstand wird geändert
  Future bearbeitenVorratsItem(int? id, String name, DateTime? mdh, String? menge) async {

    final vorraete = VorratsItem(
      id: id,
      name: name,
      mdh: mdh,
      menge: menge,
      benoetigtMdh: false,
    );
    
    await VorraeteDB.instance.update(vorraete);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mindesthaltbarkeit hinzufügen"),
      ),
      body: Center( child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.mdhHinzufuegenListe[0].name),
            Text( ausgewaehltesDatum != null ? '$ausgewaehltesDatum'.split(' ')[0] : 'Kein Datum ausgewählt.'),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                key: const Key('CupertinoDatePicker'),
                mode: CupertinoDatePickerMode.date,
                initialDateTime: heutigesDatum,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState((){
                    ausgewaehltesDatum = newDateTime;
                  });
                },
              ),
            ),
          ]
        ),
      ),
      persistentFooterButtons: [
        TextButton(
          child: const Text("Nächster Gegenstand"),
          onPressed: () {
            bearbeitenVorratsItem(
              widget.mdhHinzufuegenListe[0].id,
              widget.mdhHinzufuegenListe[0].name,
              ausgewaehltesDatum,
              widget.mdhHinzufuegenListe[0].menge 
            ); 
            widget.mdhHinzufuegenListe.removeAt(0);
            if(widget.mdhHinzufuegenListe.isNotEmpty){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MdhHinzufuegenPage(mdhHinzufuegenListe: widget.mdhHinzufuegenListe)),
              );
            } else {
              Navigator.pushReplacementNamed(context, '/Vorratsliste');
            }
          }
        ),
      ],
    );
  }
}