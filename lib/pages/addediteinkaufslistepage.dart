import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/databaseeinkaufsliste.dart';
import 'package:lebensmittelplaner/model/einkaufsliste.dart';

class AddEditEinkaufslistePage extends StatefulWidget {
  final Einkaufsliste? einkaufsliste;

  const AddEditEinkaufslistePage({Key? key, this.einkaufsliste}) : super(key: key);

  @override
  State<AddEditEinkaufslistePage> createState() => _AddEditEinkaufslistePageState();
}

class _AddEditEinkaufslistePageState extends State<AddEditEinkaufslistePage> {
  late TextEditingController nameController;
  late TextEditingController mengeController;
  String? nameError;
  String? mengeError;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.einkaufsliste?.name ?? '');
    mengeController = TextEditingController(text: widget.einkaufsliste?.menge ?? '');
  }

  Future<void> addEinkaufsliste(int? id, String name, String menge) async {
    if (name.isEmpty || menge.isEmpty) {
      setState(() {
        nameError = name.isEmpty ? 'Das Feld "Name" darf nicht leer sein.' : null;
        mengeError = menge.isEmpty ? 'Das Feld "Menge" darf nicht leer sein.' : null;
      });
      return;
    }
    if (!isNumeric(menge)) {
      setState(() {
        mengeError = 'Die Menge muss eine Zahl sein.';
      });
      return;
    }

    final einkaufsliste = Einkaufsliste(
      id: id,
      name: name,
      menge: menge,
    );

    if (einkaufsliste.id == null) {
      await einkaufslisteDB.instance.create(einkaufsliste);
    } else {
      await einkaufslisteDB.instance.update(einkaufsliste);
    }
    // Zurück zur vorherigen Seite nach dem Hinzufügen
    Navigator.of(context).pop();
  }

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Vor dem Schließen des Bildschirms eine Bestätigung anzeigen
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Vorgang abbrechen'),
            content: Text('Möchten Sie den Vorgang wirklich abbrechen? Ihre Änderungen gehen dabei verloren.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Zurück'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Abbrechen'),
              ),
            ],
          ),
        ) ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Einkaufsliste hinzufügen"),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  errorText: nameError,
                ),
              ),
              TextField(
                controller: mengeController,
                decoration: InputDecoration(
                  hintText: 'Menge',
                  errorText: mengeError,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextButton(
                onPressed: () async {
                  // Vor dem Hinzufügen Fehlermeldung zurücksetzen
                  setState(() {
                    nameError = null;
                    mengeError = null;
                  });
                  // Einkaufsliste hinzufügen
                  await addEinkaufsliste(
                    widget.einkaufsliste?.id,
                    nameController.text,
                    mengeController.text,
                  );
                },
                child: Text('Hinzufügen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
