//Name des Datenbankschemas
const String tableVorraete = 'vorraete';

//Klasse um Strings zu erstellen für Datenbank Queries
class VorratsItemFields {

  static final List<String> values = [
    id, name, mdh, menge, benoetigtMdh
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String mdh = 'mdh';
  static const String menge = 'menge';
  static const String benoetigtMdh = 'benoetigtMdh';
}

class VorratsItem {
  final int? id;
  final String name;
  final DateTime? mdh;
  final String? menge;
  final bool benoetigtMdh;

  const VorratsItem({this.id, required this.name, this.mdh, this.menge, required this.benoetigtMdh});


//Methode um Kopie einer Instanz zu erstellen
  VorratsItem copy({
    int? id,
    String? name,
    DateTime? mdh,
    String? menge,
    bool? benoetigtMdh
  }) =>
  VorratsItem(
    id: id ?? this.id,
    name: name ?? this.name,
    mdh: mdh ?? this.mdh,
    menge: menge ?? this.menge,
    benoetigtMdh: benoetigtMdh ?? this.benoetigtMdh
    );
  
  //Wandelt Einträge aus der SQFlite Datenbank, welche durch reaf geholt werden, von Json in ein Dart Objekt um.
  static VorratsItem fromJson(Map<String, Object?> json) => VorratsItem(
    id: json[VorratsItemFields.id] as int?,
    name: json[VorratsItemFields.name] as String,
    mdh: json[VorratsItemFields.mdh] != null ? DateTime.parse(json[VorratsItemFields.mdh] as String) : null,
    menge: json[VorratsItemFields.menge] as String?,
    benoetigtMdh: json[VorratsItemFields.benoetigtMdh] == 1 ? true : false,
  );

//Wandelt Dart Objekte in Json-Format um für die SQFLite Datenbank
  Map<String, Object?> toJson() => {
    VorratsItemFields.id: id,
    VorratsItemFields.name: name,
    VorratsItemFields.mdh: mdh?.toIso8601String(),
    VorratsItemFields.menge: menge,
    VorratsItemFields.benoetigtMdh: benoetigtMdh
  };
}