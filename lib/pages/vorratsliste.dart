import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/database.dart';
import 'package:lebensmittelplaner/model/lebensmittel.dart';
import 'package:lebensmittelplaner/pages/addeditvorratsliste.dart';
import 'package:lebensmittelplaner/widget/vorratslisteCardWidget.dart';
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
      body: Column(
        children: alleVorratsLebensmittel.map((lebensmittel) => vorratslisteCardWidget(lebensmittel)).toList(),
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