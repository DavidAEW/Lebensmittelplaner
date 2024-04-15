import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/databaseeinkaufsliste.dart';
import 'package:lebensmittelplaner/database/databasevorraete.dart';
import 'package:lebensmittelplaner/model/einkaufsliste.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:lebensmittelplaner/pages/addediteinkaufslistepage.dart';

class EinkaufslistePage extends StatefulWidget {
    const EinkaufslistePage({super.key});

@override
    State<EinkaufslistePage> createState() => _EinkaufslistePageState();

}

class _EinkaufslistePageState extends State<EinkaufslistePage> {
  late List<Einkaufsliste> einkaufslisteList = [];
  bool isLoading = false;

    @override 
  void initState() {
    super.initState();

    refreshEinkaufsliste();
  }

  //   @override
  // void dispose() {
  //   einkaufslisteDB.instance.close();

  //   super.dispose();
  // }

    Future refreshEinkaufsliste() async {
    setState(() => isLoading = true);

    einkaufslisteList = await einkaufslisteDB.instance.read();

    setState(() => isLoading = false);
 
  }

Future deleteEinkaufsliste(id) async{
  await einkaufslisteDB.instance.delete(id);
}

Future addVorraete(String name, String? menge) async {

  final vorraete = Vorraete(
    name: name,
    menge: menge,
  );

  await meineDatenbank.instance.create(vorraete);
}

      @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Vorratsliste"),
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Vorratsliste');
              },
            ),
          ],
        ),
      body: ListView.builder(
        itemCount: einkaufslisteList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Column( children: [
                Text(einkaufslisteList[index].name),
                Text(einkaufslisteList[index].menge as String),
              ]),

              leading:
              IconButton(
                onPressed: () async {
                  await deleteEinkaufsliste(einkaufslisteList[index].id);
                  addVorraete(einkaufslisteList[index].name, einkaufslisteList[index].menge);
                  refreshEinkaufsliste();
                },
                icon: const Icon(Icons.check),
              ),

              trailing: 
              IconButton(
                onPressed: () async {
                  await deleteEinkaufsliste(einkaufslisteList[index].id);
                  refreshEinkaufsliste();
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
              MaterialPageRoute(builder: (context) => const AddEditEinkaufslistePage()),
            ).then((_) {
              refreshEinkaufsliste();
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