final String tableLebensmittel = 'lebensmittel';

class LebensmittelFields {

  static final List<String> values = [
    id, name, mdh, menge
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String mdh = 'mdh';
  static final String menge = 'menge';
}

class Lebensmittel {
  final int? id;
  final String name;
  final DateTime? mdh;
  final String? menge;

  const Lebensmittel({this.id, required this.name, this.mdh, this.menge});

  Lebensmittel copy({
    int? id,
    String? name,
    DateTime? mdh,
    String? menge
  }) =>
  Lebensmittel(
    id: id ?? this.id,
    name: name ?? this.name,
    mdh: mdh ?? this.mdh,
    menge: menge ?? this.menge
    );
  
  static Lebensmittel fromJson(Map<String, Object?> json) => Lebensmittel(
    id: json[LebensmittelFields.id] as int?,
    name: json[LebensmittelFields.name] as String,
    mdh: json[LebensmittelFields.mdh] != null ? DateTime.parse(json[LebensmittelFields.mdh] as String) : null,
    menge: json[LebensmittelFields.menge] as String?
  );

  Map<String, Object?> toJson() => {
    LebensmittelFields.id: id,
    LebensmittelFields.name: name,
    LebensmittelFields.mdh: mdh != null ? mdh!.toIso8601String() : null,
    LebensmittelFields.menge: menge
  };
}