import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/databasevorraete.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:flutter/cupertino.dart';

class AddEditVorratslistePage extends StatefulWidget {
  final Vorraete? vorraete;
<<<<<<< Updated upstream
  
=======

>>>>>>> Stashed changes
  const AddEditVorratslistePage({Key? key, this.vorraete}) : super(key: key);

  @override
  State<AddEditVorratslistePage> createState() => _AddEditVorratslistePageState();
}

class _AddEditVorratslistePageState extends State<AddEditVorratslistePage> {
<<<<<<< Updated upstream
    DateTime? gewahltesDatum;
    late bool benoetigtMdh;
    DateTime heutigesDatum = DateTime.now();
    late TextEditingController nameController;
    late TextEditingController mengeController;
=======
  DateTime? gewahltesDatum;
  late bool benoetigtMdh;
  DateTime heutigesDatum = DateTime.now();
  late TextEditingController nameController;
  late TextEditingController mengeController;
  String? mengeError;
>>>>>>> Stashed changes

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.vorraete?.name ?? '');
    mengeController = TextEditingController(text: widget.vorraete?.menge ?? '');
    gewahltesDatum = widget.vorraete?.mdh ?? null;
    heutigesDatum = widget.vorraete?.mdh ?? heutigesDatum;
    benoetigtMdh = widget.vorraete?.benoetigtMdh ?? false;
  }

<<<<<<< Updated upstream
    Future addEditVorraete(int? id, String name, DateTime? mdh, String? menge, bool benoetigtMdh) async {
=======
  Future<void> addEditVorraete(int? id, String name, DateTime? mdh, String? menge, bool benoetigtMdh) async {
    if (!isNumeric(menge)) {
      setState(() {
        mengeError = 'Die Menge muss eine Zahl sein.';
      });
      return;
    }
>>>>>>> Stashed changes

      final vorraete = Vorraete(
        id: id,
        name: name,
        mdh: mdh,
        menge: menge,
        benoetigtMdh: benoetigtMdh,
      );

<<<<<<< Updated upstream
      if(vorraete.id == null){
        await meineDatenbank.instance.create(vorraete);
      } else{
        await meineDatenbank.instance.update(vorraete);
      }
    }
=======
    if (vorraete.id == null) {
      await meineDatenbank.instance.create(vorraete);
    } else {
      await meineDatenbank.instance.update(vorraete);
    }

    // Zurück zur vorherigen Seite nach dem Hinzufügen
    Navigator.of(context).pop();
  }

  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vorratsgegenstand hinzufügen"),
      ),
      body: Center (
<<<<<<< Updated upstream
        child: 
          Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                )
              ),

              TextField(
                controller: mengeController,
                decoration: InputDecoration(
                  hintText: 'Menge',
                )
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
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: <Widget>[
              //     Text("${gewahltesDatum?.toLocal()}".split(' ')[0]),
              //     const SizedBox(height: 20.0,),
              //     ElevatedButton(
              //       onPressed: () => _selectDate(context),
              //       child: const Text('Select date'),
              //     ),
              //   ],
              // ),
              TextButton(
                onPressed: () async {
                  addEditVorraete(
                    widget.vorraete?.id, 
                    nameController.text, 
                    gewahltesDatum, 
                    mengeController.text, 
                  benoetigtMdh);
                  Navigator.of(context).pop();
                }, 
                child: 
                  Text('Hinzufügen'),
              )
            ],
        )
=======
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
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
                // Vor dem Hinzufügen Fehlermeldung zurücksetzen
                setState(() {
                  mengeError = null;
                });
                // Vorratsgegenstand hinzufügen/bearbeiten
                await addEditVorraete(
                    widget.vorraete?.id,
                    nameController.text,
                    gewahltesDatum,
                    mengeController.text,
                    benoetigtMdh
                );
              },
              child: Text('Hinzufügen'),
            )
          ],
        ),
>>>>>>> Stashed changes
      ),
    );
  }
}
