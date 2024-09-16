import 'package:flutter/material.dart';
import 'package:comunique2024/page/page_annuaire.dart';
import 'package:comunique2024/page/page_home.dart';
import 'package:comunique2024/page/page_header_footer.dart';
import 'package:comunique2024/page/bdd/utilisateur.dart';
import 'package:comunique2024/page/bdd/bdd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: Header(),
        body: const AnnuairePage(),
        bottomNavigationBar: Footer(currentIndex: 3),
      ),
    );
  }
}
