import 'package:flutter/material.dart';

class Einkaufsliste extends StatefulWidget {
  const Einkaufsliste({super.key});

  @override
  State<Einkaufsliste> createState() => _EinkaufslisteState();
}

class _EinkaufslisteState extends State<Einkaufsliste> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
    appBar: AppBar(
      title: const Text("Einkaufsliste"),
    ),
    body: const Center(
      child: Text("Liste an Sachen die eingekauft werden müssen"),
    ),
    floatingActionButton: FloatingActionButton(
      child: Text('Vorratsliste'),
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/Vorratsliste');
      },
    ),
  );
  }
}