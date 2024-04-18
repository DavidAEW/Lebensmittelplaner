import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/databasevorraete.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:flutter/cupertino.dart';

class AddEditVorratslistePage extends StatefulWidget {

  final Vorraete? vorraete;

  const AddEditVorratslistePage({Key? key, this.vorraete}) : super(key: key);

  @override
  State<AddEditVorratslistePage> createState() => _AddEditVorratslistePageState();
}

class _AddEditVorratslistePageState extends State<AddEditVorratslistePage> {
  DateTime? gewahltesDatum;
  late bool benoetigtMdh;
  DateTime heutigesDatum = DateTime.now();
  late TextEditingController nameController;
  late TextEditingController mengeController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.vorraete?.name ?? '');
    mengeController = TextEditingController(text: widget.vorraete?.menge ?? '');
    gewahltesDatum = widget.vorraete?.mdh;
    heutigesDatum = widget.vorraete?.mdh ?? heutigesDatum;
    benoetigtMdh = widget.vorraete?.benoetigtMdh ?? false;
  }

  Future<void> addEditVorraete(int? id, String name, DateTime? mdh, String? menge, bool benoetigtMdh) async {
    final vorraete = Vorraete(
      id: id,
      name: name,
      mdh: mdh,
      menge: menge,
      benoetigtMdh: benoetigtMdh,
    );

    if(vorraete.id == null){
      await meineDatenbank.instance.create(vorraete);
    } else{
      await meineDatenbank.instance.update(vorraete);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Dialog für den Abbruch anzeigen
        final bool? result = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Vorgang abbrechen'),
              content: Text('Möchten Sie den Vorgang wirklich abbrechen? Ihre Änderungen gehen dabei verloren.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Zurück'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Abbrechen'),
                ),
              ],
            );
          },
        );
        return result ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Vorratsgegenstand hinzufügen"),
        ),
        body: Center (
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              TextField(
                controller: mengeController,
                decoration: const InputDecoration(
                  hintText: 'Menge',
                ),
              ),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: heutigesDatum,
                  onDateTimeChanged: (DateTime newDateTime) {
                    gewahltesDatum = newDateTime;
                  },
                ),
              ),
              TextButton(
                onPressed: () async {
                  addEditVorraete(
                    widget.vorraete?.id,
                    nameController.text,
                    gewahltesDatum,
                    mengeController.text,
                    benoetigtMdh,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Hinzufügen'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
