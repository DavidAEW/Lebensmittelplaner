//Name des Datenbankschemas
const String tableEinkaufsliste = 'einkaufsliste';

//Klasse um Strings zu erstellen für Datenbank Queries
class EinkaufslisteItemFields {

  static final List<String> values = [
    id, name, menge
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String menge = 'menge';
}

class EinkaufslisteItem {
  final int? id;
  final String name;
  final String? menge;

  const EinkaufslisteItem({this.id, required this.name, this.menge});

//Methode um Kopie einer Instanz zu erstellen und zurückzugeben
  EinkaufslisteItem copy({
    int? id,
    String? name,
    String? menge
  }) =>
  EinkaufslisteItem(
    id: id ?? this.id,
    name: name ?? this.name,
    menge: menge ?? this.menge
    );
  
  //Wandelt Einträge aus der SQFlite Datenbank, welche durch reaf geholt werden, von Json in ein Dart Objekt um.
  static EinkaufslisteItem fromJson(Map<String, Object?> json) => EinkaufslisteItem(
    id: json[EinkaufslisteItemFields.id] as int?,
    name: json[EinkaufslisteItemFields.name] as String,
    menge: json[EinkaufslisteItemFields.menge] as String?
  );

//Wandelt Dart Objekte in Json-Format um für die SQFLite Datenbank
  Map<String, Object?> toJson() => {
    EinkaufslisteItemFields.id: id,
    EinkaufslisteItemFields.name: name,
    EinkaufslisteItemFields.menge: menge
  };
}