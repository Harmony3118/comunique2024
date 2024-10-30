import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:comunique2024/page/bdd/utilisateur.dart';
import 'package:comunique2024/page/bdd/event.dart';
import 'package:comunique2024/page/bdd/role.dart';
//import 'package:comunique2024/page/bdd/grpDiffusion.dart';
//import 'package:comunique2024/page/bdd/inscription.dart';
import 'package:comunique2024/page/bdd/organisation.dart';
//import 'package:comunique2024/page/bdd/status.dart';

class AppDataBase {
  AppDataBase._(); // Constructeur privé

  // Instance unique de la classe AppDataBase
  static final AppDataBase instance = AppDataBase._();

  // Base de données SQLite
  static Database? _database; // Variable pour stocker BDD, init null

  // Méthode pour obtenir la base de données, en la créant si elle n'existe pas encore
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB(); // else
    return _database!;
  }

  // Méthode d'initialisation de la base de données
  initDB() async {
    // Ouverture de la base de données avec sqflite
    return await openDatabase(
      join(await getDatabasesPath(),
          'AppDataBase.db'), // Chemin de la base de données
      version: 1,
      onCreate: (db, version) async {
        // Création des tables si elles n'existent pas encore
        await db.execute(
            "CREATE TABLE utilisateur (idUtilisateur INTEGER PRIMARY KEY, nom TEXT, prenom TEXT, email TEXT, promotion INTEGER)");
        await db.execute(
            "CREATE TABLE role (idRole INTEGER PRIMARY KEY, nomRole TEXT)");
        await db.execute(
            "CREATE TABLE organisation (idOrga INTEGER PRIMARY KEY, nom TEXT)");
        await db.execute(
            "CREATE TABLE statuts (idUtilisateur INTEGER, idOrganisation INTEGER, idRole INTEGER, annee INTEGER, PRIMARY KEY (idUtilisateur, idOrganisation, idRole), FOREIGN KEY (idUtilisateur) REFERENCES utilisateur(idUtilisateur), FOREIGN KEY (idOrganisation) REFERENCES organisation(idOrga), FOREIGN KEY (idRole) REFERENCES role(idRole))");
        await db.execute(
            "CREATE TABLE event (idPost INTEGER PRIMARY KEY, idUtilisateur INTEGER, status INTEGER, idGroupe INTEGER, objet TEXT, titre TEXT, date TEXT, hDebut TEXT, hFin TEXT, lieu TEXT, tarif INTEGER, commentaire TEXT, fichier TEXT, inscription INTEGER, FOREIGN KEY (idUtilisateur) REFERENCES utilisateur(idUtilisateur), FOREIGN KEY (idGroupe) REFERENCES grpDiffusion(idGroupe), FOREIGN KEY (status) REFERENCES role(idRole))");
        await db.execute(
            "CREATE TABLE inscription (idPost INTEGER, idUtilisateur INTEGER, nbPlaces INTEGER, PRIMARY KEY (idPost, idUtilisateur), FOREIGN KEY (idPost) REFERENCES event(idPost), FOREIGN KEY (idUtilisateur) REFERENCES utilisateur(idUtilisateur))");
        // pour l'instant le nb de place n'est pas utilisé
        await db.execute(
            "CREATE TABLE grpDiffusion (idGroupe INTEGER PRIMARY KEY, nom TEXT)");
        // ajouter la liste des membres
        await db.execute(
            "CREATE TABLE groupe_utilisateur (idGroupe INTEGER, idUtilisateur INTEGER, PRIMARY KEY (idGroupe, idUtilisateur), FOREIGN KEY (idGroupe) REFERENCES grpDiffusion(idGroupe), FOREIGN KEY (idUtilisateur) REFERENCES utilisateur(idUtilisateur))");
        // pas de doc encore, il faut voir si c'est vraiment utile

        // pré remplir les tables
        await _preRemplirOrganisation(db);
        await _preRemplirRole(db);
      },
    );
  }

  Future<void> _preRemplirOrganisation(Database db) async {
    List<Map<String, dynamic>> organisations = [
      {'idOrga': 0, 'nom': 'BDE'},
      {'idOrga': 1, 'nom': 'BDS'},
      {'idOrga': 2, 'nom': 'BDA'},
      {'idOrga': 3, 'nom': 'JE'},
      {'idOrga': 4, 'nom': 'Binks'},
      {'idOrga': 5, 'nom': 'Club Musique'},
      // ajouter tous les clubs -> BDA, BDS, BDE
      {'idOrga': 6, 'nom': 'Admisnistration'},
      {'idOrga': 7, 'nom': 'Professeur'},
      {'idOrga': 8, 'nom': 'Doctorant'},
      {'idOrga': 9, 'nom': 'Alumnis'},
      {'idOrga': 10, 'nom': 'Bordeaux Inp'},
    ];

    for (var org in organisations) {
      await db.insert('organisation', org);
    }
  }

  Future<void> _preRemplirRole(Database db) async {
    List<Map<String, dynamic>> listRole = [
      {'idRole': 0, 'nomRole': 'Président'},
      {'idRole': 1, 'nomRole': 'Vis-président'},
      {'idRole': 2, 'nomRole': 'Secrétaire'},
      {'idRole': 3, 'nomRole': 'Trésorier'},
      {'idRole': 4, 'nomRole': 'Vis-trésorier'},
      {'idRole': 5, 'nomRole': 'Respo clubs'},
      {'idRole': 6, 'nomRole': 'Respo partenariats'},
      {'idRole': 7, 'nomRole': 'Pole events'},
      {'idRole': 8, 'nomRole': 'Pole communications'},
      {'idRole': 9, 'nomRole': 'Pole logistique'},
      // ajouter les bon rôles : bureaux, club, administration, professeur
    ];

    for (var r in listRole) {
      await db.insert('role', r);
    }
  }

  void insertOrganisation(Organisation orga) async {
    final Database db = await database;
    await db.insert(
      'organisation',
      orga.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void insertRole(Role role) async {
    final Database db = await database;
    await db.insert(
      'role',
      role.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Méthode pour insérer un utilisateur dans la base de données
  void insertUtilisateur(Utilisateur utilisateur) async {
    final Database db = await database;
    await db.insert(
      'utilisateur',
      utilisateur.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Modifier un utilisateur
  void updateUtilisateur(Utilisateur utilisateur) async {
    final Database db = await database;
    await db.update("utilisateur", utilisateur.toMap(),
        where: "id = ?", whereArgs: [utilisateur.idUtilisateur]);
  }

  // Supprimer un utilisateur
  void deleteUtilisateur(Utilisateur utilisateur) async {
    final Database db = await database;
    db.delete("utilisateur",
        where: "id = ?", whereArgs: [utilisateur.idUtilisateur]);
  }

  Future<List<Utilisateur>> utilisateur() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('utilisateur');
    List<Utilisateur> utilisateur = List.generate(maps.length, (i) {
      return Utilisateur.fromMap(maps[i]);
    });

    if (utilisateur.isEmpty) {
      for (Utilisateur utilisateur in defaultUtilisateur) {
        insertUtilisateur(utilisateur);
      }
      utilisateur = defaultUtilisateur;
    }

    return utilisateur;
  }

  // Méthodes pour la table "event"
  void insertEvent(Event event) async {
    final Database db = await database;

    await db.insert(
      'event',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Modifier un événement
  void updateEvent(Event event) async {
    final Database db = await database;
    await db.update(
      "event",
      event.toMap(),
      where: "idPost = ?",
      whereArgs: [event.idPost],
    );
  }

  // Supprimer un événement
  void deleteEvent(Event event) async {
    final Database db = await database;
    db.delete("event", where: "IdPost = ?", whereArgs: [event.idPost]);
  }

  // Obtenir la liste des événements
  Future<List<Event>> getEvents() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('event');
    List<Event> events = List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });

    return events;
  }

  // Liste d'utilisateurs par défaut
  final List<Utilisateur> defaultUtilisateur = [
    Utilisateur(
      1,
      "Lolie",
      "Reydellet",
      "lreydellet@ensc.fr",
      2025,
    ),
  ];
/*
  final Event defaultEvent = Event(
    1,
    //utilisateur,
    1,
    "Objet par défaut",
    "Titre par défaut",
    "Statut par défaut", //status par défault
    "Date par défaut",
    "Heure de début par défaut",
    "Heure de fin par défaut",
    "Lieu par défaut",
    2, //tarif
    "Commentaire par défaut",
    "Fichier par défaut",
    false,
  );
  

// Méthode pour initialiser un événement par défaut
  Future<void> initializeDefaultEvent() async {
    final Database db = await database;
    final List<Map<String, dynamic>> events = await db.query('event');

    if (events.isEmpty) {
      insertEvent(defaultEvent);
    }
  }
 */
}
