import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/database_einkaufsliste.dart';
import 'package:lebensmittelplaner/model/einkaufsliste.dart';

class AddEditEinkaufslistePage extends StatefulWidget {

  final EinkaufslisteItem? einkaufsliste;
  
  const AddEditEinkaufslistePage({super.key, this.einkaufsliste});

  @override
  State<AddEditEinkaufslistePage> createState() => _AddEditEinkaufslistePageState();
}

class _AddEditEinkaufslistePageState extends State<AddEditEinkaufslistePage> {
    late TextEditingController nameController;
    late TextEditingController mengeController;
    String? nameError;
    late bool hinzufuegenErfolgreich;

//Initalisierungmethode beim Starten der Seite
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.einkaufsliste?.name ?? '');
    mengeController = TextEditingController(text: widget.einkaufsliste?.menge ?? '');
  }

//Einkaufslistenitem wird erstellt und anschließend 
//an Create Methode weitergeben um es in der Datenbank zu persistieren
    Future hinzufuegenEinkaufslisteItem(int? id, String name, String menge) async {
      //Prüfung ob, Name in Eingabefeld leer ist
      if (name.isEmpty) {
        setState(() {
          nameError = 'Das Feld darf nicht leer sein.';
         });
         hinzufuegenErfolgreich = false;
        return;
      }
      hinzufuegenErfolgreich = true;

      final einkaufsliste = EinkaufslisteItem(
        id: id,
        name: name,
        menge: menge,
      );

      if(einkaufsliste.id == null){
        await EinkaufslisteDB.instance.create(einkaufsliste);
      } else{
        await EinkaufslisteDB.instance.update(einkaufsliste);
      }
      return;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einkaufsliste bearbeiten'),
      ),
      body: Center (
        child: 
          Column(
            children: [
              TextField(
                controller: nameController,
                key: const Key('addNameField'),
                decoration: InputDecoration(
                  hintText: 'Name',
                  errorText: nameError,
                ),
              ),

              TextField(
                controller: mengeController,
                decoration: const InputDecoration(
                  hintText: 'Menge',
                )
              ),

              OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                ),
                onPressed: () {
                  setState(() {
                    nameError = null;
                  });
                hinzufuegenEinkaufslisteItem(
                  widget.einkaufsliste?.id, 
                  nameController.text, 
                  mengeController.text
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