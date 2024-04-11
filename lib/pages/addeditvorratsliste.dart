import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/database.dart';
import 'package:lebensmittelplaner/model/lebensmittel.dart';

import 'dart:developer';

class AddEditVorratslistePage extends StatefulWidget {
  const AddEditVorratslistePage({super.key});

  @override
  State<AddEditVorratslistePage> createState() => _AddEditVorratslistePageState();
}

class _AddEditVorratslistePageState extends State<AddEditVorratslistePage> {
    DateTime gewahltesDatum = DateTime.now();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController mengeController = TextEditingController();

    Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: gewahltesDatum,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
      if (picked != null && picked != gewahltesDatum) {
        setState(() {
          gewahltesDatum = picked;
        });
      }
    } 
    Future addLebensmittel(String name, DateTime mdh, String menge) async {

      final lebensmittel = Lebensmittel(
        name: name,
        mdh: mdh,
        menge: menge,
      );

      await meineDatenbank.instance.create(lebensmittel);
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
                  Text("${gewahltesDatum.toLocal()}".split(' ')[0]),
                  const SizedBox(height: 20.0,),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select date'),
                  ),
                ],
              ),
              TextButton(
                onPressed: () async {
                  addLebensmittel(nameController.text, gewahltesDatum, mengeController.text);
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