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

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.einkaufsliste?.name ?? '');
    mengeController = TextEditingController(text: widget.einkaufsliste?.menge ?? '');
  }

    Future addEinkaufsliste(int? id, String name, String menge) async {

      final einkaufsliste = Einkaufsliste(
        id: id,
        name: name,
        menge: menge,
      );

      if(einkaufsliste.id == null){
        await einkaufslisteDB.instance.create(einkaufsliste);
      } else{
        await einkaufslisteDB.instance.update(einkaufsliste);
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Einkaufsliste hinzufügen"),
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

              TextButton(
                onPressed: () async {
                  addEinkaufsliste(widget.einkaufsliste?.id, nameController.text, mengeController.text);
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