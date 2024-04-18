import 'package:flutter_test/flutter_test.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:lebensmittelplaner/model/einkaufsliste.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
void main() {

  databaseFactory = databaseFactoryFfi;

  test('toJson einkaufsliste', (){
    EinkaufslisteItem inital = const EinkaufslisteItem(id: 123, name: 'Einkaufsliste 1', menge: '5');
    Map<String, Object?> actual = inital.toJson();
    expect(actual, 
    {
    '_id': 123,
    'name': 'Einkaufsliste 1',
    'menge': '5'
    }
    );
  });


  test('fromJson einkaufsliste', (){
    Map<String, Object?> inital =  {'_id': 123, 'name': 'Virrat 1','menge': '5'};
    EinkaufslisteItem actual = EinkaufslisteItem.fromJson(inital);
    expect(actual.id == const EinkaufslisteItem(id: 123, name: 'Einkaufsliste 1', menge: '5').id,true);
  });

    test('toJson Vorratsitem', (){
    VorratsItem inital = VorratsItem(
      id: 1, 
    name: 'Milch',
    mdh: DateTime(2024, 6, 30), 
    menge: '1 Liter',
    benoetigtMdh: true,);

    Map<String, Object?> actual = inital.toJson();
    expect(actual, 
    {
    "_id": 1,
    "name": "Milch",
    "mdh": "2024-06-30T00:00:00.000",
    "menge": "1 Liter",
    "benoetigtMdh": true
    }
    );
  });


  test('fromJson Vorratsitem', (){
    Map<String, Object?> inital =  {
      "id": 1,  
      "name": "Milch",
      "mdh": "2024-06-30T00:00:00.000",
      "menge": "1 Liter",
      "benoetigtMdh": true
    };
    VorratsItem actual = VorratsItem.fromJson(inital);
    expect(actual.mdh == VorratsItem(id: 1, 
    name: 'Milch',
    mdh: DateTime(2024, 6, 30), 
    menge: '1 Liter',
    benoetigtMdh: true,).mdh,true);
  });
}