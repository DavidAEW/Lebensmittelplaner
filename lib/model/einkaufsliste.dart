const String tableEinkaufsliste = 'einkaufsliste';

class EinkaufslisteFields {

  static final List<String> values = [
    id, name, menge
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String menge = 'menge';
}

class Einkaufsliste {
  final int? id;
  final String name;
  final String? menge;

  const Einkaufsliste({this.id, required this.name, this.menge});

  Einkaufsliste copy({
    int? id,
    String? name,
    String? menge
  }) =>
  Einkaufsliste(
    id: id ?? this.id,
    name: name ?? this.name,
    menge: menge ?? this.menge
    );
  
  static Einkaufsliste fromJson(Map<String, Object?> json) => Einkaufsliste(
    id: json[EinkaufslisteFields.id] as int?,
    name: json[EinkaufslisteFields.name] as String,
    menge: json[EinkaufslisteFields.menge] as String?
  );

  Map<String, Object?> toJson() => {
    EinkaufslisteFields.id: id,
    EinkaufslisteFields.name: name,
    EinkaufslisteFields.menge: menge
  };
}