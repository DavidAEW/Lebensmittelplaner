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

    // Future addLebensmittel() async {

    //   String testname = "Testobjekt";
    //   DateTime testmdh = DateTime(2024, 4, 10, 0, 0, 0);
    //   String testmenge = "10";

    //   final lebensmittel = Lebensmittel(
    //     name: testname,
    //     mdh: testmdh,
    //     menge: testmenge
    //   );

    //   await meineDatenbank.instance.create(lebensmittel);
    //   refreshLebensmittel();
    // }

    Future refreshLebensmittel() async {
    setState(() => isLoading = true);

    alleVorratsLebensmittel = await meineDatenbank.instance.read();

    setState(() => isLoading = false);
 
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
      body: Center(
           child: Column(
            children: List.generate(
            alleVorratsLebensmittel.length,
            (index) {
              final lebensmittel = alleVorratsLebensmittel[index];
              return Row(
                children: [
                  Text(lebensmittel.name),
                  Text(formatter.format(lebensmittel.mdh!).toString()), //Könnte Probleme machen das Ausrufezeichen!!
                  Text(lebensmittel.menge as String),
                ],
              );
            }
            )
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
              refreshLebensmittel();
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () async {
            log("remove Lebensmittel");
          },
        ),
      ]
    );
  }
}