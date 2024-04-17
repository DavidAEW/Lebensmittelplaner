const String tableVorraete = 'vorraete';

class VorraeteFields {

  static final List<String> values = [
    id, name, mdh, menge, benoetigtMdh
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String mdh = 'mdh';
  static const String menge = 'menge';
  static const String benoetigtMdh = 'benoetigtMdh';
}

class Vorraete {
  final int? id;
  final String name;
  final DateTime? mdh;
  final String? menge;
  final bool benoetigtMdh;

  const Vorraete({this.id, required this.name, this.mdh, this.menge, required this.benoetigtMdh});

  Vorraete copy({
    int? id,
    String? name,
    DateTime? mdh,
    String? menge,
    bool? benoetigtMdh
  }) =>
  Vorraete(
    id: id ?? this.id,
    name: name ?? this.name,
    mdh: mdh ?? this.mdh,
    menge: menge ?? this.menge,
    benoetigtMdh: benoetigtMdh ?? this.benoetigtMdh
    );
  
  static Vorraete fromJson(Map<String, Object?> json) => Vorraete(
    id: json[VorraeteFields.id] as int?,
    name: json[VorraeteFields.name] as String,
    mdh: json[VorraeteFields.mdh] != null ? DateTime.parse(json[VorraeteFields.mdh] as String) : null,
    menge: json[VorraeteFields.menge] as String?,
    benoetigtMdh: json[VorraeteFields.benoetigtMdh] == 1 ? true : false,
  );

  Map<String, Object?> toJson() => {
    VorraeteFields.id: id,
    VorraeteFields.name: name,
    VorraeteFields.mdh: mdh?.toIso8601String(),
    VorraeteFields.menge: menge,
    VorraeteFields.benoetigtMdh: benoetigtMdh
  };
}