import 'package:flutter/material.dart';

class Vorratsliste extends StatelessWidget {
  const Vorratsliste({super.key}); //was ist das?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text("Vorratsliste"),
    ),
    body: const Center(
      child: Text("Liste an Vorräten"),
    ),
    floatingActionButton: FloatingActionButton(
      child: Text('Einkaufsliste'),
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/Einkaufsliste');
      },
    ),
  );
  }
}