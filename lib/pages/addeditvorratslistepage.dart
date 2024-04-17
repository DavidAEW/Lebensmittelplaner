import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/databasevorraete.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:flutter/cupertino.dart';

class AddEditVorratslistePage extends StatefulWidget {

  final Vorraete? vorraete;
  
  const AddEditVorratslistePage({super.key, this.vorraete});

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

    Future addEditVorraete(int? id, String name, DateTime? mdh, String? menge, bool benoetigtMdh) async {

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vorratsgegenstand hinzufügen"),
      ),
      body: Center (
        child: 
          Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                )
              ),

              TextField(
                controller: mengeController,
                decoration: const InputDecoration(
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
                  const Text('Hinzufügen'),
              )
            ],
        )
      ),
    );
  }
}