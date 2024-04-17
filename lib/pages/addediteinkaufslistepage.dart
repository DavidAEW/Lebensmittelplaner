import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/databaseeinkaufsliste.dart';
import 'package:lebensmittelplaner/model/einkaufsliste.dart';

class AddEditEinkaufslistePage extends StatefulWidget {
  final Einkaufsliste? einkaufsliste;

  const AddEditEinkaufslistePage({super.key, this.einkaufsliste});

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

  Future<void> addEinkaufsliste(int? id, String name, String menge) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Einkaufsliste hinzufügen"),
      ),
      body: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  )
              ),
              const SizedBox(height: 6),
              TextField(
                  controller: mengeController,
                  decoration: const InputDecoration(
                    hintText: 'Menge',
                  )
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  addEinkaufsliste(widget.einkaufsliste?.id, nameController.text, mengeController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Hinzufügen'),
              )
            ],
          )
      ),
    );
  }
}
