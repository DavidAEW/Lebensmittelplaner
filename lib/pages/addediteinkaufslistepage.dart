import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/databaseeinkaufsliste.dart';
import 'package:lebensmittelplaner/model/einkaufsliste.dart';

class AddEditEinkaufslistePage extends StatefulWidget {
  const AddEditEinkaufslistePage({super.key});

  @override
  State<AddEditEinkaufslistePage> createState() => _AddEditEinkaufslistePageState();
}

class _AddEditEinkaufslistePageState extends State<AddEditEinkaufslistePage> {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController mengeController = TextEditingController();

    Future addEinkaufsliste(String name, String menge) async {

      final einkaufsliste = Einkaufsliste(
        name: name,
        menge: menge,
      );

      await einkaufslisteDB.instance.create(einkaufsliste);
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

              TextButton(
                onPressed: () async {
                  addEinkaufsliste(nameController.text, mengeController.text);
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