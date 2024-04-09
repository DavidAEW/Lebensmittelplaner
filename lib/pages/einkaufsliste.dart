import 'package:flutter/material.dart';

class Einkaufsliste extends StatelessWidget {
  const Einkaufsliste({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text("Einkaufsliste"),
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'Open shopping cart',
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/Vorratsliste');
          },
        ),
      ],
    ),
    body: const Center(
      child: Text("Liste an Sachen die eingekauft werden müssen"),
    ),
  );
  }
}