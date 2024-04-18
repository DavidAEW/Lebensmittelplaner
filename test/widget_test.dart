// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lebensmittelplaner/model/vorraete.dart';
import 'package:lebensmittelplaner/pages/mdh_hinzufuegen_page.dart';
import 'package:lebensmittelplaner/pages/bearbeiten_einkaufsliste_page.dart';
import 'package:lebensmittelplaner/pages/bearbeiten_vorratsliste_page.dart';
import 'package:lebensmittelplaner/pages/einkaufsliste_page.dart';
import 'package:lebensmittelplaner/pages/vorratslistepage.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {

  databaseFactory = databaseFactoryFfi;
  testWidgets("startingPage", (WidgetTester tester) async {

    await tester.pumpWidget(const MaterialApp(home: VorratslistePage() ));
    await tester.pump();

    expect(find.byKey(const ValueKey("Go to shoppinglist")), findsOne);
  });

  testWidgets('showTrashcan', (WidgetTester tester) async {
    final removebutton = find.byKey(const ValueKey('Remove Button'));

    await tester.pumpWidget(const MaterialApp(home: VorratslistePage() ));

    await tester.tap(removebutton);
    await tester.pump();

    expect(find.byKey(const ValueKey('trashcan Icon')), findsNothing);
  });

  testWidgets('einkaufsliste', (WidgetTester tester) async {

    await tester.pumpWidget(const MaterialApp(home: EinkaufslistePage() ));
    await tester.pump();

    expect(find.byKey(const ValueKey('Go to vorratsliste')), findsOne);
  });

testWidgets('einkaufsliste2', (WidgetTester tester) async {
    final removebutton = find.byKey(const ValueKey('Remove Button'));

    await tester.pumpWidget(const MaterialApp(home: EinkaufslistePage() ));

    await tester.tap(removebutton);
    await tester.pump();

    expect(find.byKey(const ValueKey('trashcan Icon')), findsNothing);
  });

  testWidgets('step 3. einkaufsliste hinzufügen', (WidgetTester tester) async {
    final addNameField = find.byKey(const ValueKey('addNameField'));

    await tester.pumpWidget(const MaterialApp(home: AddEditEinkaufslistePage() ));
    await tester.enterText(addNameField, 'Gurken');
    await tester.pump();

    expect(find.text('Gurken'), findsOneWidget);
  });

    testWidgets('addEditVorratsliste', (WidgetTester tester) async {
    final addNameField = find.byKey(const ValueKey('addNameField'));

    await tester.pumpWidget(const MaterialApp(home: AddEditVorratslistePage() ));
    await tester.enterText(addNameField, 'Gurken');
    await tester.pump();

    expect(find.text('Gurken'), findsOneWidget);
  });

  testWidgets('mdhHinzufuegenPage', (WidgetTester tester) async {

    final List<VorratsItem> mdhHinzufuegenListe = [
      VorratsItem(name: 'Vorrat 1', mdh: DateTime(2024, 6, 30), menge: '2 Stück', benoetigtMdh: true),
      VorratsItem(name: 'Vorrat 2', mdh: DateTime(2024, 6, 30), menge: '1 Stück', benoetigtMdh: true),
    ];

    await tester.pumpWidget(MaterialApp(home: MdhHinzufuegenPage(mdhHinzufuegenListe: mdhHinzufuegenListe)));
    await tester.pump();

    expect(find.byKey(const ValueKey('CupertinoDatePicker')), findsOneWidget);
  });

  testWidgets('Get to Bearbeiten Einkaufsliste Page', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EinkaufslistePage() ));

    // Tippe auf das IconButton
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(); 

    // Überprüfe, ob die AddEditEinkaufslistePage angezeigt wird
    expect(find.byType(AddEditEinkaufslistePage), findsOneWidget);
  });

    testWidgets('Get to Bearbeiten Vorratsliste Page', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: VorratslistePage() ));

    // Tippe auf das IconButton
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(); 

    // Überprüfe, ob die AddEditEinkaufslistePage angezeigt wird
    expect(find.byType(AddEditVorratslistePage), findsOneWidget);
  });
}
