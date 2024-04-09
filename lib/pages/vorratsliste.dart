import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/database.dart';
import 'package:lebensmittelplaner/model/lebensmittel.dart';
import 'package:intl/intl.dart'; // for date format
import 'package:intl/date_symbol_data_local.dart'; // for other locales
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

    Future addLebensmittel() async {

      String testname = "Testobjekt";
      DateTime testmdh = DateTime(2024, 4, 10, 0, 0, 0);
      String testmenge = "10";

      final lebensmittel = Lebensmittel(
        name: testname,
        mdh: testmdh,
        menge: testmenge
      );

      await meineDatenbank.instance.create(lebensmittel);
      refreshLebensmittel();
    }

    Future refreshLebensmittel() async {
    setState(() => isLoading = true);

    log('Hallo Welt! Log im refreshLebensmittel()');

    alleVorratsLebensmittel = await meineDatenbank.instance.read();

    int laenge = alleVorratsLebensmittel.length;
    log('$laenge');

    setState(() => isLoading = false);
 
  }

      @override
    Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: const Text("Vorratsliste"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => addLebensmittel()),
      // floatingActionButton: FloatingActionButton(
      //   child: Text('Einkaufsliste'),
      //   onPressed: () {
      //     Navigator.pushReplacementNamed(context, '/Einkaufsliste');
      //   },
      // ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     appBar: AppBar(
//       title: const Text("Vorratsliste"),
//     ),
//     body: const Center(
//       child: Text("Liste an Vorräten"),
//     ),
//     floatingActionButton: FloatingActionButton(
//       child: Text('Einkaufsliste'),
//       onPressed: () {
//         Navigator.pushReplacementNamed(context, '/Einkaufsliste');
//       },
//     ),
//   );
//   }
// }