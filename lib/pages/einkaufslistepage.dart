import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/databaseeinkaufsliste.dart';
import 'package:lebensmittelplaner/database/databasevorraete.dart';
import 'package:lebensmittelplaner/model/einkaufsliste.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:lebensmittelplaner/pages/addediteinkaufslistepage.dart';

class EinkaufslistePage extends StatefulWidget {
  const EinkaufslistePage({Key? key}) : super(key: key);

  @override
  State<EinkaufslistePage> createState() => _EinkaufslistePageState();
}

class _EinkaufslistePageState extends State<EinkaufslistePage> {
  late List<Einkaufsliste> einkaufslisteList = [];
  bool isLoading = false;
  bool showDeleteButton = false;

  @override
  void initState() {
    super.initState();
    refreshEinkaufsliste();
  }

  Future<void> refreshEinkaufsliste() async {
    setState(() => isLoading = true);
    einkaufslisteList = await einkaufslisteDB.instance.read();
    setState(() => isLoading = false);
  }

  Future<void> deleteEinkaufsliste(int id) async {
    await einkaufslisteDB.instance.delete(id);
  }

  Future<void> addVorraete(String name, String? menge) async {
    final vorraete = Vorraete(
      name: name,
      menge: menge,
      benoetigtMdh: true,
    );
    await meineDatenbank.instance.create(vorraete);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Einkaufsliste"),
        leading: Image.asset('assets/Logo.jpg'), // Hier füge ich das Logo hinzu
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/Vorratsliste');
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: einkaufslisteList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditEinkaufslistePage(einkaufsliste: einkaufslisteList[index]),
                  ),
                ).then((_) {
                  refreshEinkaufsliste();
                });
              },
              title: Column(
                children: [
                  Text(einkaufslisteList[index].name),
                  Text(einkaufslisteList[index].menge as String),
                ],
              ),
              leading: IconButton(
                onPressed: () async {
                  await deleteEinkaufsliste(einkaufslisteList[index].id!);
                  addVorraete(einkaufslisteList[index].name, einkaufslisteList[index].menge);
                  refreshEinkaufsliste();
                },
                icon: const Icon(Icons.check),
              ),
              trailing: showDeleteButton
                  ? IconButton(
                onPressed: () async {
                  await deleteEinkaufsliste(einkaufslisteList[index].id!);
                  refreshEinkaufsliste();
                },
                icon: const Icon(Icons.delete),
              )
                  : null,
            ),
          );
        },
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
          onPressed: () {
            setState(() {
              showDeleteButton = !showDeleteButton;
            });
          },
        ),
      ],
    );
  }
}
