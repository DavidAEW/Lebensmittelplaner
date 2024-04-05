class Gegenstaende {

  int id;
  String name;
  String? haltbarkeit;
  String? menge;

  Gegenstaende({required this.id, required this.name, this.haltbarkeit, this.menge});

    factory Gegenstaende.fromSqfliteDatabase(Map<String, dynamic> map) => Gegenstaende(
    id: map['id']?.toInt() ?? 0,
    name: map['name'] ?? '',
  );

}