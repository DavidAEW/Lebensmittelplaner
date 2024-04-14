final String tableVorraete = 'vorraete';

class VorraeteFields {

  static final List<String> values = [
    id, name, mdh, menge
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String mdh = 'mdh';
  static final String menge = 'menge';
}

class Vorraete {
  final int? id;
  final String name;
  final DateTime? mdh;
  final String? menge;

  const Vorraete({this.id, required this.name, this.mdh, this.menge});

  Vorraete copy({
    int? id,
    String? name,
    DateTime? mdh,
    String? menge
  }) =>
  Vorraete(
    id: id ?? this.id,
    name: name ?? this.name,
    mdh: mdh ?? this.mdh,
    menge: menge ?? this.menge
    );
  
  static Vorraete fromJson(Map<String, Object?> json) => Vorraete(
    id: json[VorraeteFields.id] as int?,
    name: json[VorraeteFields.name] as String,
    mdh: json[VorraeteFields.mdh] != null ? DateTime.parse(json[VorraeteFields.mdh] as String) : null,
    menge: json[VorraeteFields.menge] as String?
  );

  Map<String, Object?> toJson() => {
    VorraeteFields.id: id,
    VorraeteFields.name: name,
    VorraeteFields.mdh: mdh != null ? mdh!.toIso8601String() : null,
    VorraeteFields.menge: menge
  };
}