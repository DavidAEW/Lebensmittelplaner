import 'package:flutter_test/flutter_test.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:lebensmittelplaner/model/einkaufsliste.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:lebensmittelplaner/database/database_einkaufsliste.dart';

void main() {

  //InMemoryDatenbank, um diese zu testen
  databaseFactory = databaseFactoryFfi;
  sqfliteFfiInit();


  test('Teste Create in EinkaufslistenDatenbank', () async {
    EinkaufslisteDB.instance.create(const EinkaufslisteItem(name: 'Einkaufsliste 1'));
    late List<EinkaufslisteItem> einkaufslisteItemList = [];
     einkaufslisteItemList = await EinkaufslisteDB.instance.read();
    expect(einkaufslisteItemList[0].name,'Einkaufsliste 1');
  });

  test('Teste Update in EinkaufslistenDatenbank', () async {
    late List<EinkaufslisteItem> einkaufslisteItemList = [];
    einkaufslisteItemList = await EinkaufslisteDB.instance.read();
    EinkaufslisteItem itemMitNeuemNamen = EinkaufslisteItem(id: einkaufslisteItemList[0].id, name: 'neuer Name');
    await EinkaufslisteDB.instance.update(itemMitNeuemNamen);
     einkaufslisteItemList = await EinkaufslisteDB.instance.read();
    expect(einkaufslisteItemList[0].name,'neuer Name');
  });

  test('Teste Delete in EinkaufslistenDatenbank', () async {
    late List<EinkaufslisteItem> einkaufslisteItemList = [];
    einkaufslisteItemList = await EinkaufslisteDB.instance.read();
    EinkaufslisteDB.instance.delete(einkaufslisteItemList[0].id!);
     einkaufslisteItemList = await EinkaufslisteDB.instance.read();
    expect(einkaufslisteItemList.length,0);
  });

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