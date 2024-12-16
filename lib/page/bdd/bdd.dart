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
            "CREATE TABLE utilisateur (idUtilisateur INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, prenom TEXT, email TEXT, promotion INTEGER, image BLOB)");
        await db.execute(
            "CREATE TABLE role (idRole INTEGER PRIMARY KEY AUTOINCREMENT, nomRole TEXT)");
        await db.execute(
            "CREATE TABLE organisation (idOrga INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, image BLOB, color INTEGER)");
        await db.execute(
            "CREATE TABLE statuts (idUtilisateur INTEGER, idOrganisation INTEGER, idRole INTEGER, annee INTEGER, PRIMARY KEY (idUtilisateur, idOrganisation, idRole), FOREIGN KEY (idUtilisateur) REFERENCES utilisateur(idUtilisateur), FOREIGN KEY (idOrganisation) REFERENCES organisation(idOrga), FOREIGN KEY (idRole) REFERENCES role(idRole))");
        await db.execute(
            "CREATE TABLE event (idPost INTEGER PRIMARY KEY AUTOINCREMENT, idUtilisateur INTEGER, idOrganisation INTEGER, status INTEGER, idGroupe INTEGER, objet TEXT, titre TEXT, date TEXT, hDebut TEXT, hFin TEXT, lieu TEXT, tarif DOUBLE, commentaire TEXT, fichier TEXT, inscriptionAppli INTEGER, inscriptionHelloAsso INTEGER, FOREIGN KEY (idUtilisateur) REFERENCES utilisateur(idUtilisateur), FOREIGN KEY (idGroupe) REFERENCES grpDiffusion(idGroupe), FOREIGN KEY (status) REFERENCES role(idRole))");
        await db.execute(
            "CREATE TABLE inscription (idPost INTEGER, idUtilisateur INTEGER, nbPlaces INTEGER, PRIMARY KEY (idPost, idUtilisateur), FOREIGN KEY (idPost) REFERENCES event(idPost), FOREIGN KEY (idUtilisateur) REFERENCES utilisateur(idUtilisateur))");
        // pour l'instant le nb de place n'est pas utilisé
        await db.execute(
            "CREATE TABLE grpDiffusion (idGroupe INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT)");
        // ajouter la liste des membres
        await db.execute(
            "CREATE TABLE groupe_utilisateur (idGroupe INTEGER, idUtilisateur INTEGER, PRIMARY KEY (idGroupe, idUtilisateur), FOREIGN KEY (idGroupe) REFERENCES grpDiffusion(idGroupe), FOREIGN KEY (idUtilisateur) REFERENCES utilisateur(idUtilisateur))");
        // pas de doc encore, il faut voir si c'est vraiment utile

        // pré remplir les tables
        await _preRemplirOrganisation(db);
        await _preRemplirRole(db);
        await _preRemplirEvent(db);
      },
    );
  }

  Future<void> _preRemplirOrganisation(Database db) async {
    Color c = Color(0xB5D08FBA);
    List<Map<String, dynamic>> organisations = [
      {'nom': 'BDE', 'color': 0xB5DEB5A7},
      {'nom': 'BDS', 'color': 0xB5A7DEDB},
      {'nom': 'BDA', 'color': 0xB5F5E9AB},
      {'nom': 'JE', 'color': 0xB5BBD08F},
      {'nom': 'Binks', 'color': 0x000000},
      {'nom': 'Club Musique', 'color': 0xB5F5E9AB},
      // ajouter tous les clubs -> BDA, BDS, BDE
      {'nom': 'Admisnistration', 'color': 0xB5D08FBA},
      {'nom': 'Professeur', 'color': 0xB5D08FBA},
      {'nom': 'Doctorant', 'color': 0xB5D08FBA},
      {'nom': 'Alumnis', 'color': 0xB5D08FBA},
    ];

    for (var org in organisations) {
      await db.insert('organisation', org);
    }
  }

  Future<void> _preRemplirRole(Database db) async {
    List<Map<String, dynamic>> listRole = [
      {'nomRole': 'Président'},
      {'nomRole': 'Vice-président'},
      {'nomRole': 'Secrétaire'},
      {'nomRole': 'Trésorier'},
      {'nomRole': 'Vice-trésorier'},
      {'nomRole': 'Respo clubs'},
      {'nomRole': 'Respo partenariats'},
      {'nomRole': 'Pôle events'},
      {'nomRole': 'Pôle communications'},
      {'nomRole': 'Pôle logistique'},
      // ajouter les bon rôles : bureaux, club, administration, professeur
    ];

    for (var r in listRole) {
      await db.insert('role', r);
    }
  }

  Future<void> _preRemplirEvent(Database db) async {
    double x = 2.0;
    List<Map<String, dynamic>> listEvent = [
      {
        'idUtilisateur': 1,
        'idOrganisation': 3,
        'status': 2,
        'idGroupe': 2,
        'objet': "Il faut une description de l'event",
        'titre': "Chorale",
        'date': "2024-11-18",
        'hDebut': "11:00",
        'hFin': "12:00",
        'lieu': "Ecole",
        'tarif': x,
        'commentaire': "commentaire",
        'inscriptionAppli': 1,
        'inscriptionHelloAsso': 0,
      },
      {
        'idUtilisateur': 1,
        'idOrganisation': 4,
        'status': 2,
        'idGroupe': 2,
        'objet': "Il faut une description de l'event",
        'titre': "Formation i2c",
        'date': "2023-08-16",
        'hDebut': "12:30",
        'hFin': "14:00",
        'lieu': "Salle S103",
        'tarif': x,
        'commentaire': "commentaire",
        'inscriptionAppli': 0,
        'inscriptionHelloAsso': 1,
      },
      {
        'idUtilisateur': 1,
        'idOrganisation': 1,
        'status': 2,
        'idGroupe': 2,
        'objet': "Il faut une description de l'event",
        'titre': "Chorale",
        'date': "2024-11-18",
        'hDebut': "11:00",
        'hFin': "12:00",
        'lieu': "Ecole",
        'tarif': x,
        'commentaire': "commentaire",
        'inscriptionAppli': 1,
        'inscriptionHelloAsso': 0,
      },
      {
        'idUtilisateur': 1,
        'idOrganisation': 2,
        'status': 2,
        'idGroupe': 2,
        'objet': "Il faut une description de l'event",
        'titre': "Chorale",
        'date': "2024-11-18",
        'hDebut': "11:00",
        'hFin': "12:00",
        'lieu': "Ecole",
        'tarif': x,
        'commentaire': "commentaire",
        'inscriptionAppli': 1,
        'inscriptionHelloAsso': 0,
      },
      {
        'idUtilisateur': 1,
        'idOrganisation': 5,
        'status': 2,
        'idGroupe': 2,
        'objet': "Il faut une description de l'event",
        'titre': "Chorale",
        'date': "2024-11-18",
        'hDebut': "11:00",
        'hFin': "12:00",
        'lieu': "Ecole",
        'tarif': x,
        'commentaire': "commentaire",
        'inscriptionAppli': 1,
        'inscriptionHelloAsso': 0,
      },
      {
        'idUtilisateur': 1,
        'idOrganisation': 7,
        'status': 2,
        'idGroupe': 2,
        'objet': "Il faut une description de l'event",
        'titre': "Chorale",
        'date': "2024-11-18",
        'hDebut': "11:00",
        'hFin': "12:00",
        'lieu': "Ecole",
        'tarif': x,
        'commentaire': "commentaire",
        'inscriptionAppli': 1,
        'inscriptionHelloAsso': 0,
      },
    ];
    print("fin des initialisations des events");

    for (var e in listEvent) {
      await db.insert('event', e);
    }
    print("fin ajout event");
  }

  // final List<Map<String, dynamic>> events = [
//   //   {
//     "office": "BDS",
//     "role": "Respo WES",
//     "eventTitle": 'WES',
//     "eventDate": 'Du 12 au 14 janvier 2024',
//     "eventTime": '',
//     "eventLocation": 'Station Pas de la Case, Andorre',
//     "imageUrl": 'https://via.placeholder.com/150',
//     "color": const Color.fromRGBO(167, 222, 219, 0.71),
//     "isPinned": false,
//   },
//   {
//     "office": "BDA",
//     "role": "Club musique",
//     "eventTitle": 'Répétition',
//     "eventDate": 'Le mardi 21 septembre 2023',
//     "eventTime": 'De 12h30 à 13h30',
//     "eventLocation": 'Salle S103',
//     "imageUrl": 'https://via.placeholder.com/150',
//     "color": const Color.fromRGBO(245, 233, 171, 0.71),
//     "isPinned": false,
//   },
// ];

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
  Future<void> insertUtilisateur(Utilisateur utilisateur) async {
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
  Future<void> insertEvent(Event event) async {
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
      idUtilisateur: 1,
      nom: "Lolie",
      prenom: "Reydellet",
      email: "lreydellet@ensc.fr",
      promotion: 2025,
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
