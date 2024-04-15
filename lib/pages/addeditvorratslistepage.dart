import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/databasevorraete.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';

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
    gewahltesDatum = widget.vorraete?.mdh ?? null;
    benoetigtMdh = widget.vorraete?.benoetigtMdh ?? false;
  }

    Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: heutigesDatum,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
      if (picked != null && picked != gewahltesDatum) {
        setState(() {
          gewahltesDatum = picked;
        });
      }
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
        
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("${gewahltesDatum?.toLocal()}".split(' ')[0]),
                  const SizedBox(height: 20.0,),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select date'),
                  ),
                ],
              ),
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
      ),
    );
  }
}