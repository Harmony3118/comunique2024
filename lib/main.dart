import 'package:flutter/material.dart';
import 'package:comunique2024/page/page_header_footer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:comunique2024/page/bdd/bdd.dart';
import 'package:comunique2024/page/page_header_footer.dart';
import 'package:comunique2024/page/page_annuaire.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/page_file_actualite.dart';
import 'package:comunique2024/page/page_form_crea_groupe.dart';
import 'package:comunique2024/page/page_form_absence.dart';
import 'package:comunique2024/page/page_annuaire.dart';
import 'package:comunique2024/page/page_liens_externes.dart'; //rajouté par pascal
import 'package:comunique2024/page/page_connection.dart';
import 'package:comunique2024/page/page_header_footer.dart';
import 'package:comunique2024/page/page_inscription.dart';
import 'package:comunique2024/page/page_parametre.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  print("Lancement de l'application");
  // Nécessaire pour les opérations async dans main()
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise sqflite pour les environnements de bureau
  //sqfliteFfiInit();
  //databaseFactory = databaseFactoryFfi;

  // Chemin de la base de données
  //final databasePath = join(await getDatabasesPath(), 'AppDataBase.db');
  // Supprimer la base de données pour forcer la recréation
  //await deleteDatabase(databasePath);
  //print("Base de données supprimée. Initialisation...");

  // Initialiser la base de données en accédant à AppDataBase.instance.database
  /*final db = await AppDataBase.instance.database;
  print("Initialisation de la base de données réussie.");

  // Vérifier si les données de la table "organisation" existent
  final List<Map<String, dynamic>> organisations =
      await db.query('organisation');
  print(organisations);*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr', ''), // Français
      ],
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

      home: const PageConnection(),
      // home: Scaffold(
      //   appBar: Header(),
      //   body: AnnuairePage(),
      //   bottomNavigationBar: Footer(),
      // ),

    //  home: Scaffold(
      //  appBar: Header(),
        //body: CreaGroupe(),
        //       bottomNavigationBar: Footer(currentIndex: 3),
     // ),
    );
  }
}
       

      // home: BasePage(
      //   // test 
      //   currentIndex: 0,
      //   body: const PageConnection(),
      // ),

//,changePage:(int index){}
