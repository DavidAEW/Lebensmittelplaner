import 'package:flutter/material.dart';
import 'package:lebensmittelplaner/database/diedatenbank.dart';
import 'package:lebensmittelplaner/model/gegenstaende.dart';
import 'package:lebensmittelplaner/widget/e_gegenstand_widget.dart';

class Vorratsliste extends StatefulWidget {
  const Vorratsliste({Key? key}) : super(key: key);

  @override
  State<Vorratsliste> createState() => _VorratslisteState();
}

class _VorratslisteState extends State<Vorratsliste> {
  late Future<List<Gegenstaende>> meineVorraete;
  final DieDatenbank diedatenbank = DieDatenbank();

  @override
  void initState() {
    super.initState();
    fetchGegenstaende();
  }

  void fetchGegenstaende() {
    setState(() {
      meineVorraete = diedatenbank.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vorratsliste"),
      ),
      body: FutureBuilder<List<Gegenstaende>>(
        future: meineVorraete,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final gegenstaende = snapshot.data!;
            return gegenstaende.isEmpty
                ? const Center(
                    child: Text(
                      'Keine Vorräte...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemCount: gegenstaende.length,
                    itemBuilder: (context, index) {
                      final gegenstand = gegenstaende[index];
                      return ListTile(
                        title: Text(
                          gegenstand.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await diedatenbank.deleteById(gegenstand.id);
                            fetchGegenstaende();
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      );
                    },
                  );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('Vorräte hinzufügen'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CreateGegenstandWidget(
              onSubmit: (name) async {
                await diedatenbank.create(name: name);
                if (mounted) {
                  fetchGegenstaende();
                  Navigator.of(context).pop();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
