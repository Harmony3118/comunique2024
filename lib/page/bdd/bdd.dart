import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:comunique2024/page/bdd/utilisateur.dart';
import 'package:comunique2024/page/bdd/event.dart';

class AppDataBase {
  AppDataBase._(); // Constructeur privé

  // Instance unique de la classe AppDataBase
  static final AppDataBase instance = AppDataBase._();

  // Base de données SQLite
  static Database?
      _database; // Variable pour stocker la base de données, initialisée à null

  // Méthode pour obtenir la base de données, en la créant si elle n'existe pas encore
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Si la base de données n'est pas encore initialisée, on l'initialise
    _database = await initDB();
    return _database!;
  }

  // Méthode d'initialisation de la base de données
  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Ouverture de la base de données avec sqflite
    return await openDatabase(
      join(await getDatabasesPath(),
          'AppDataBase.db'), // Chemin de la base de données
      onCreate: (db, version) {
        // Création de la table "utilisateur" et "event" si elles n'existent pas encore
        db.execute(
            "CREATE TABLE utilisateur (id INTEGER PRIMARY KEY, nom TEXT, prenom TEXT)");

        db.execute(
          "CREATE TABLE event (IdPost INTEGER PRIMARY KEY, IdEleve INTEGER, Objet TEXT, Titre TEXT, Statut TEXT, Date TEXT, hDebut TEXT, hFin TEXT, Lieu TEXT, Tarif TEXT, Commentaire TEXT, Fichier TEXT, Inscription INTEGER)",
        );
      },
      version: 1,
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
        where: "id = ?", whereArgs: [utilisateur.idEleve]);
  }

  // Supprimer un utilisateur
  void deleteUtilisateur(Utilisateur utilisateur) async {
    final Database db = await database;
    db.delete("utilisateur", where: "id = ?", whereArgs: [utilisateur.idEleve]);
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
