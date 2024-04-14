import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/database.dart';
import 'package:lebensmittelplaner/model/lebensmittel.dart';
import 'package:lebensmittelplaner/pages/addeditvorratsliste.dart';
import 'package:intl/intl.dart'; // for date format
import 'dart:developer';

class VorratslistePage extends StatefulWidget {
    const VorratslistePage({super.key});

@override
    State<VorratslistePage> createState() => _VorratslistePageState();

}

class _VorratslistePageState extends State<VorratslistePage> {
  late List<Lebensmittel> alleVorratsLebensmittel = [];
  bool isLoading = false;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

    @override 
  void initState() {
    super.initState();

    refreshLebensmittel();
  }

  //   @override
  // void dispose() {
  //   meineDatenbank.instance.close();

  //   super.dispose();
  // }

    Future refreshLebensmittel() async {
    setState(() => isLoading = true);

    alleVorratsLebensmittel = await meineDatenbank.instance.read();

    setState(() => isLoading = false);
 
  }

Future deleteLebensmittel(id) async{
  await meineDatenbank.instance.delete(id);
}

      @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Vorratsliste"),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Einkaufsliste');
              },
            ),
          ],
        ),
      body: ListView.builder(
        itemCount: alleVorratsLebensmittel.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Column( children: [
                Text(alleVorratsLebensmittel[index].name),
                Text(formatter.format(alleVorratsLebensmittel[index].mdh!).toString()), //Könnte Probleme machen das Ausrufezeichen!!
                Text(alleVorratsLebensmittel[index].menge as String),
              ]),
              trailing: 
              IconButton(
                onPressed: () async {
                  await deleteLebensmittel(alleVorratsLebensmittel[index].id);
                  refreshLebensmittel();
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        }
      ),

      persistentFooterButtons: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddEditVorratslistePage()),
            ).then((_) {
              refreshLebensmittel();
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () async {
          },
        ),
      ]
    );
  }
}