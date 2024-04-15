import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/databasevorraete.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:lebensmittelplaner/pages/addeditvorratslistepage.dart';
import 'package:intl/intl.dart'; // for date format

class VorratslistePage extends StatefulWidget {
    const VorratslistePage({super.key});

@override
    State<VorratslistePage> createState() => _VorratslistePageState();

}

class _VorratslistePageState extends State<VorratslistePage> {
  late List<Vorraete> vorraeteList = [];
  bool isLoading = false;
  bool showdeleteButton = false;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

    @override 
  void initState() {
    super.initState();

    refreshVorraete();
  }

  //   @override
  // void dispose() {
  //   meineDatenbank.instance.close();

  //   super.dispose();
  // }

    Future refreshVorraete() async {
    setState(() => isLoading = true);

    vorraeteList = await meineDatenbank.instance.read();

    setState(() => isLoading = false);
    }

Future deleteVorraete(id) async{
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
        itemCount: vorraeteList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Column( children: [
                Text(vorraeteList[index].name),
                Text(vorraeteList[index].mdh != null ? formatter.format(vorraeteList[index].mdh!).toString() : ''), //Könnte Probleme machen das Ausrufezeichen!!
                Text(vorraeteList[index].menge as String),
              ]),
              trailing: 
              showdeleteButton ? IconButton(
                onPressed: () async {
                  await deleteVorraete(vorraeteList[index].id);
                  refreshVorraete();
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
              MaterialPageRoute(builder: (context) => const AddEditVorratslistePage()),
            ).then((_) {
              refreshVorraete();
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.remove),
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