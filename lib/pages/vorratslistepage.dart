import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/databasevorraete.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:lebensmittelplaner/pages/MdhHinzufuegenPage.dart';
import 'package:lebensmittelplaner/pages/addeditvorratslistepage.dart';
import 'package:intl/intl.dart'; // for date format

class VorratslistePage extends StatefulWidget {
  const VorratslistePage({Key? key}) : super(key: key);

  @override
  State<VorratslistePage> createState() => _VorratslistePageState();
}

class _VorratslistePageState extends State<VorratslistePage> {
  late List<Vorraete> vorraeteList = [];
  late List<Vorraete> vorrateListMitBenoetigenMdh = [];
  bool isLoading = false;
  bool showDeleteButton = false;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    refreshVorraete();
  }

  Future<void> refreshVorraete() async {
    setState(() => isLoading = true);
    vorraeteList = await meineDatenbank.instance.read();
    vorrateListMitBenoetigenMdh = vorraeteList.where((obj) => obj.benoetigtMdh == true).toList();
    setState(() => isLoading = false);
  }

  Future<void> deleteVorraete(int id) async {
    await meineDatenbank.instance.delete(id);
  }

  Color getDateColor(DateTime? mdh) {
    if (mdh != null) {
      final now = DateTime.now();
      if (mdh.isBefore(now)) {
        return Colors.red; // Rot, wenn MHD in der Vergangenheit liegt
      } else {
        return Colors.green; // Grün, wenn MHD in der Zukunft liegt
      }
    } else {
      return Colors.black; // Standardfarbe, wenn kein MHD angegeben ist
    }
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
        leading: Image.asset('assets/Logo.jpg'), // Bild hinzugefügt
      ),
      body: Column(
        children: [
          if (vorrateListMitBenoetigenMdh.isNotEmpty)
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MdhHinzufuegenPage(mdhHinzufuegenListe: vorrateListMitBenoetigenMdh)),
                  ).then((_) {
                    refreshVorraete();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${vorrateListMitBenoetigenMdh.length} Items benötigen eine Mindesthaltbarkeit. Hier klicken, um diese hinzuzufügen',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: vorraeteList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddEditVorratslistePage(vorraete: vorraeteList[index])),
                      ).then((_) {
                        refreshVorraete();
                      });
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vorraeteList[index].name),
                        Text(vorraeteList[index].menge as String),
                        Text(
                          vorraeteList[index].mdh != null ? 'Mindesthaltbarkeit: ${formatter.format(vorraeteList[index].mdh!)}' : '',
                          style: TextStyle(color: getDateColor(vorraeteList[index].mdh)), // Farbe je nach MHD
                        ),
                      ],
                    ),
                    trailing: showDeleteButton
                        ? IconButton(
                      onPressed: () async {
                        await deleteVorraete(vorraeteList[index].id!);
                        refreshVorraete();
                      },
                      icon: const Icon(Icons.delete),
                    )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddEditVorratslistePage()),
            ).then((_) {
              refreshVorraete();
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