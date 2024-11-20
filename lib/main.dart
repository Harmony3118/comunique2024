import 'package:comunique2024/page/page_form_absence.dart';
import 'package:comunique2024/page/page_form_soiree.dart';
import 'package:comunique2024/page/page_header_footer.dart';
import 'package:comunique2024/page/page_inscription.dart';
import 'package:comunique2024/page/page_inscription_suite.dart';
import 'package:flutter/material.dart';
import 'package:comunique2024/page/page_header_footer.dart';
import 'package:comunique2024/page/page_annuaire.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/page_file_actualite.dart';
import 'package:comunique2024/page/page_connection.dart';

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
      // ******************************************************************************
      // ******************************************************************************
      // ***************************** Tester votre code ******************************
      // ******************************************************************************
      // Pour tester votre code :
      //    - mettre la ligne suivante (home: const PageConnection(),) en commantaire
      //    - enlever les commentaires des 5 lignes suivantes pour les exécuter (Scaffold())
      //    - Changer AnnuairePage en votre class que vous voulez tester
      //    - importer votre page au début du document

      // ******************************************************************************
      // ************************************ Fin *************************************
      // ******************************************************************************
      // ******************************************************************************

     // home: const PageConnection(),
     home: Scaffold(
        appBar: Header(),
         body: FormSoiree(),
       bottomNavigationBar: Footer(),
      ),
    );
  }
}


      // home: BasePage(
      //   // test
      //   currentIndex: 0,
      //   body: const PageConnection(),
      // ),

