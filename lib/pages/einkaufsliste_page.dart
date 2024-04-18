import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/database_einkaufsliste.dart';
import 'package:lebensmittelplaner/database/database_vorratsliste.dart';
import 'package:lebensmittelplaner/model/einkaufsliste.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:lebensmittelplaner/pages/bearbeiten_einkaufsliste_page.dart';

class EinkaufslistePage extends StatefulWidget {
    const EinkaufslistePage({super.key});

@override
    State<EinkaufslistePage> createState() => _EinkaufslistePageState();

}

class _EinkaufslistePageState extends State<EinkaufslistePage> {
  late List<EinkaufslisteItem> einkaufslisteItemList = [];
  bool isLoading = false;
  bool showdeleteButton = false;

//Initalisierungmethode beim Rendern der Page
  @override 
  void initState() {
    super.initState();

    aktualisiereEinkaufsliste();
  }

  //Einkaufsliste wird geladen/neugeladen
  Future aktualisiereEinkaufsliste() async {
    setState(() => isLoading = true);

    einkaufslisteItemList = await EinkaufslisteDB.instance.read();

    setState(() => isLoading = false);
 
  }

//Löscht einen Gegenstand persistent aus der Einkaufsliste
Future loeschenEinkaufslisteItem(id) async{
  await EinkaufslisteDB.instance.delete(id);
}

//Fügt einen Gegenstand in die Vorratsliste hinzu
Future hinzufuegenVorratsItem(String name, String? menge) async {

  final vorraete = VorratsItem(
    name: name,
    menge: menge,
    benoetigtMdh: true,
  );

  await VorraeteDB.instance.create(vorraete);
}

      @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Einkaufsliste"),
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              key: const Key('Go to vorratsliste'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Vorratsliste');
              },
            ),
          ],
        ),
      body: ListView.builder(
        itemCount: einkaufslisteItemList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => 
                AddEditEinkaufslistePage(einkaufsliste: einkaufslisteItemList[index])),
              ).then((_) {
                aktualisiereEinkaufsliste();
                });
              },
              title: Column( children: [
                Text(einkaufslisteItemList[index].name),
                Text(einkaufslisteItemList[index].menge as String),
              ]),
              leading:
              IconButton(
                onPressed: () async {
                  await loeschenEinkaufslisteItem(einkaufslisteItemList[index].id);
                  hinzufuegenVorratsItem(einkaufslisteItemList[index].name, einkaufslisteItemList[index].menge);
                  aktualisiereEinkaufsliste();
                },
                key: const Key('icon check'),
                icon: const Icon(Icons.check),
              ),

              trailing: 
              showdeleteButton ? IconButton(
                onPressed: () async {
                  await loeschenEinkaufslisteItem(einkaufslisteItemList[index].id);
                  aktualisiereEinkaufsliste();
                },
                icon: const Icon(Icons.delete),
              ) : null,
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
              aktualisiereEinkaufsliste();
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          key: const Key('Remove Button'),
          onPressed: () async {
            if(showdeleteButton){
              showdeleteButton = false;
            } else {
              showdeleteButton = true;
            }
            setState(() {
            
            });
          },
        ),
      ]
    );
  }
}