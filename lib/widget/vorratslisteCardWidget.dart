import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/model/lebensmittel.dart';
import 'package:lebensmittelplaner/database/database.dart';
import 'package:intl/intl.dart'; // for date format
import 'dart:developer';

final DateFormat formatter = DateFormat('yyyy-MM-dd');

Future deleteLebensmittel(id) async{
  await meineDatenbank.instance.delete(id);
}

Widget vorratslisteCardWidget(Lebensmittel lebensmittel){
  return Card(
    margin: EdgeInsets.fromLTRB(16,16,16,0),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: 
        [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lebensmittel.name),
                Text(formatter.format(lebensmittel.mdh!).toString()), //Könnte Probleme machen das Ausrufezeichen!!
                Text(lebensmittel.menge as String),
              ]
            ),
          ),
          IconButton(
            onPressed: () async {
              await deleteLebensmittel(lebensmittel.id);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    )
  );
}

// import 'package:flutter/material.dart';
// import 'package:lebensmittelplaner/model/lebensmittel.dart';
// import 'package:lebensmittelplaner/database/database.dart';
// import 'package:intl/intl.dart'; // for date format
// import 'dart:developer';

// class vorratslisteCardWidget extends StatefulWidget {
//   const vorratslisteCardWidget({Key? key, Lebensmittel? lebensmittel}): super(key: key);

//   @override
//   State<vorratslisteCardWidget> createState() => _vorratslisteCardWidgetState();
// }

// class _vorratslisteCardWidgetState extends State<vorratslisteCardWidget> {

//   final DateFormat formatter = DateFormat('yyyy-MM-dd');

//   Future deleteLebensmittel(id) async{
//     await meineDatenbank.instance.delete(id);
//   }
  
//   @override
//   Widget build(BuildContext context) {
//       return Card(
//     margin: EdgeInsets.fromLTRB(16,16,16,0),
//     child: Padding(
//       padding: const EdgeInsets.all(12),
//       child: Row(
//         children: 
//         [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(lebensmittel.name),
//                 Text(formatter.format(lebensmittel.mdh!).toString()), //Könnte Probleme machen das Ausrufezeichen!!
//                 Text(lebensmittel.menge as String),
//               ]
//             ),
//           ),
//           IconButton(
//             onPressed: () async {
//               await deleteLebensmittel(lebensmittel.id);
//             },
//             icon: const Icon(Icons.delete),
//           ),
//         ],
//       ),
//     )
//   );
//   }
// }