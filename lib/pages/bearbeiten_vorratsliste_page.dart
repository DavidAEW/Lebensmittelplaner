import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/database_vorratsliste.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:flutter/cupertino.dart';

class AddEditVorratslistePage extends StatefulWidget {

  final VorratsItem? vorratsItem;
  
  const AddEditVorratslistePage({super.key, this.vorratsItem});

  @override
  State<AddEditVorratslistePage> createState() => _AddEditVorratslistePageState();
}

class _AddEditVorratslistePageState extends State<AddEditVorratslistePage> {
    DateTime? ausgewaehltesDatum;
    late bool benoetigtMdh;
    DateTime heutigesDatum = DateTime.now();
    late TextEditingController nameController;
    late TextEditingController mengeController;
    String? nameError;
    late bool hinzufuegenErfolgreich;

//Initalisierungmethode beim Rendern der Page
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.vorratsItem?.name ?? '');
    mengeController = TextEditingController(text: widget.vorratsItem?.menge ?? '');
    ausgewaehltesDatum = widget.vorratsItem?.mdh;
    heutigesDatum = widget.vorratsItem?.mdh ?? heutigesDatum;
    benoetigtMdh = widget.vorratsItem?.benoetigtMdh ?? false;
  }

//Einkaufslistenitem wird erstellt und anschließend 
//an Create weitergeben um es in der Datenbank zu persistieren
  Future hinzufuegenVorratslistenItem(int? id, String name, DateTime? mdh, String? menge, bool benoetigtMdh) async {
    //Prüfung ob, Name in Eingabefeld leer ist
    if (name.isEmpty) {
      setState(() {
        nameError = 'Das Feld darf nicht leer sein.';
        });
        hinzufuegenErfolgreich = false;
      return;
    }
    hinzufuegenErfolgreich = true;

    final vorraete = VorratsItem(
      id: id,
      name: name,
      mdh: mdh,
      menge: menge,
      benoetigtMdh: benoetigtMdh,
    );

    if(vorraete.id == null){
      await VorraeteDB.instance.create(vorraete);
    } else{
      await VorraeteDB.instance.update(vorraete);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vorratsliste bearbeiten"),
      ),
      body: Center (
        child: 
          Column(
            children: [
              TextField(
                key: const Key('addNameField'),
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  errorText: nameError,
                )
              ),

              TextField(
                controller: mengeController,
                decoration: const InputDecoration(
                  hintText: 'Menge',
                )
              ),

              Text( ausgewaehltesDatum != null ? '$ausgewaehltesDatum'.split(' ')[0] : 'Kein Datum ausgewählt.'),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: heutigesDatum,
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState((){
                      ausgewaehltesDatum = newDateTime;
                    });
                  },
                ),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                ),
                onPressed: () async {
                  hinzufuegenVorratslistenItem(
                    widget.vorratsItem?.id, 
                    nameController.text, 
                    ausgewaehltesDatum, 
                    mengeController.text, 
                    benoetigtMdh
                  );
                  //Wechselt nur zur Vorratsliste zurück, 
                  //wenn Eingabefelder richtig ausgefüllt wurden
                  if (hinzufuegenErfolgreich) Navigator.of(context).pop();
                }, 
                child: 
                  const Text('Hinzufügen'),
              )
            ],
        )
      ),
    );
  }
}