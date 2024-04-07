import 'package:flutter/material.dart';

class Einkaufsliste extends StatelessWidget {
  const Einkaufsliste({super.key});

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