import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/database_vorratsliste.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:lebensmittelplaner/pages/mdh_hinzufuegen_page.dart';
import 'package:lebensmittelplaner/pages/bearbeiten_vorratsliste_page.dart';
import 'package:intl/intl.dart'; // for date format

class VorratslistePage extends StatefulWidget {
    const VorratslistePage({super.key});

@override
    State<VorratslistePage> createState() => _VorratslistePageState();

}

class _VorratslistePageState extends State<VorratslistePage> {
  late List<VorratsItem> vorratsItemList = [];
  late List<VorratsItem> vorratsListMitBenoetigenMdh = [];
  bool isLoading = false;
  bool showDeleteButton = false;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  //Initalisierungmethode beim Rendern der Page
  @override 
  void initState() {
    super.initState();

    aktualisierenVorratsliste();
  }
//Vorratsliste wird neugeladen
    Future aktualisierenVorratsliste() async {
    setState(() => isLoading = true);

    vorratsItemList = await VorraeteDB.instance.read();
    vorratsListMitBenoetigenMdh = vorratsItemList.where((obj) => obj.benoetigtMdh == true).toList();

    setState(() => isLoading = false);
    }

Future loescheVorratsitem(id) async{
  await VorraeteDB.instance.delete(id);
}

      @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Vorratsliste"),
          actions: [
            IconButton(
              key: const Key("Go to shoppinglist"),
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Einkaufsliste');
              },
            ),
          ],
        ),
      body:
        //Prüfe ob die Einkaufsliste leer ist. Wenn diese leer ist soll ein Text ausgegeben werden, asonsten alle Gegenstände in der Einkaufsliste
        vorratsItemList.isNotEmpty ?
        Column( children: [
        if (vorratsListMitBenoetigenMdh.isNotEmpty) Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MdhHinzufuegenPage(mdhHinzufuegenListe: vorratsListMitBenoetigenMdh)),
              ).then((_) {
                aktualisierenVorratsliste();
              });
            },
            child: Text(
            '${vorratsListMitBenoetigenMdh.length} Items benötigen eine Mindesthaltbarkeit. Hier klicken, um diese hinzuzufügen'),
          )
        ),
        Flexible(child:
        ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: vorratsItemList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEditVorratslistePage(vorratsItem: vorratsItemList[index])),
                ).then((_) {
                  aktualisierenVorratsliste();
                });
              },
              title: Column( children: [
                Text(vorratsItemList[index].name),
                Text(vorratsItemList[index].mdh != null ? formatter.format(vorratsItemList[index].mdh!).toString() : ''), //Könnte Probleme machen das Ausrufezeichen!!
                Text(vorratsItemList[index].menge as String),
              ]),
              trailing: 
              showDeleteButton ? IconButton(
                onPressed: () async {
                  await loescheVorratsitem(vorratsItemList[index].id);
                  aktualisierenVorratsliste();
                },
                key: const Key('trashcan Icon'),
                icon: const Icon(Icons.delete),
              ) : null,
            ),
          );
        }
      ),),
      ])
      :
      const Center( child:
        Text(
          'Vorratsliste ist leer. Drücke auf das + oder auf den ✓ in der Einkaufsliste, um Items hier hinzuzufügen.'
        ),
      ),
      persistentFooterButtons: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddEditVorratslistePage()),
            ).then((_) {
              aktualisierenVorratsliste();
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          key: const Key('Remove Button'),
          onPressed: () async {
            if(showDeleteButton){
              showDeleteButton = false;
            } else {
              showDeleteButton = true;
            }
            setState(() {
            
            });
          },
        ),
      ]
    );
  }
}