import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:comunique2024/page/bdd/utilisateur.dart';
import 'package:comunique2024/page/bdd/event.dart';
import 'package:comunique2024/page/bdd/role.dart';
//import 'package:comunique2024/page/bdd/grpDiffusion.dart';
//import 'package:comunique2024/page/bdd/inscription.dart';
import 'package:comunique2024/page/bdd/organisation.dart';

import '../page_inscription.dart';
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
            "CREATE TABLE utilisateur (idUtilisateur INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, prenom TEXT, email TEXT, mdp TEXT, promotion INTEGER, image BLOB)");
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
        await _preRemplirUtilisateur(db);
        await _preRemplirOrganisation(db);
        await _preRemplirRole(db);
        await _preRemplirEvent(db);
      },
    );
  }

  Future<void> _preRemplirOrganisation(Database db) async {
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
      {'nomRole': 'Professeur'}
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

  Future<void> _preRemplirUtilisateur(Database db) async {
    List<Map<String, dynamic>> listUtilisateur = [
      {
        'nom': "Admin",
        'prenom': "Administrateur",
        'email': "pprostwater@ensc.fr",
        'mdp': hashPassword("12345678"),
        'promotion': 2026
      },
      {
        'nom': 'Andre',
        'prenom': 'Jean-Marc',
        'email': 'Jean-Marc.Andre@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Chaniaud',
        'prenom': 'Noemie',
        'email': 'Noemie.Chaniaud@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Eyraud-Dubois',
        'prenom': 'Coralie',
        'email': 'Coralie.Dubois@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Favier',
        'prenom': 'Pierre-Alexandre',
        'email': 'Pierre-Alexandre.Favier@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Jauze',
        'prenom': 'Christophe',
        'email': 'Christophe.Jauze@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Le Blanc',
        'prenom': 'Benoit',
        'email': 'Benoit.Leblanc@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Legrand',
        'prenom': 'Pierrick',
        'email': 'Pierrick.Legrand@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Najib',
        'prenom': 'Veronique',
        'email': 'Veronique.Lespinet@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Pesquet',
        'prenom': 'Baptiste',
        'email': 'Baptiste.Pesquet@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Placin,',
        'prenom': 'Frederic',
        'email': 'Frederic.Placin@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Salotti',
        'prenom': 'Jean-Marc',
        'email': 'Jean-Marc.Salotti@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Saracco',
        'prenom': 'Jerome',
        'email': 'Jerome.Saracco@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Semal',
        'prenom': 'Catherine',
        'email': 'Catherine.Semal@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Unrein',
        'prenom': 'Helene',
        'email': 'Helene.Unrein@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Leveneur',
        'prenom': 'Sandrine',
        'email': 'Sandrine.Leveneur@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Sese',
        'prenom': 'Isabelle',
        'email': 'Isabelle.Sese@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Grall',
        'prenom': 'Christelle',
        'email': 'Christelle.Grall@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Rodier',
        'prenom': 'Marc',
        'email': 'Marc.Rodier@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Rodriguez',
        'prenom': 'Nadege',
        'email': 'Nadege.Rodriguez@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
      {
        'nom': 'Cayere',
        'prenom': 'Jean-Paul',
        'email': 'Jean-Paul.Cayere@bordeaux-inp.fr',
        'mdp': hashPassword("0"),
        'promotion': '0',
      },
    ];

    for (var u in listUtilisateur) {
      await db.insert('utilisateur', u);
    }
  }

  Future<void> _preRemplirStatut(Database db) async {
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
      {'nomRole': 'Professeur'}
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
  Future<int> insertUtilisateur(Utilisateur utilisateur) async {
    final Database db = await database;
    return await db.insert(
      'utilisateur',
      utilisateur.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Renvoie true si un utilisateur est trouvé
  Future<bool> isUserAlreadyRegistered(
      String email, String nom, String prenom, int promo) async {
    final Database db = await database;
    final result = await db.rawQuery(
      '''
      SELECT * FROM utilisateur 
      WHERE email = ? OR (nom = ? AND prenom = ? AND promotion = ?)
      ''',
      [email, nom, prenom, promo],
    );

    return result.isNotEmpty;
  }

  // renvoie true si l'indentification est correcte
  Future<int> validerUtilisateur(String email, String mdp) async {
    // Remplacez ceci par votre logique réelle
    final Database db = await database;
    final result = await db.rawQuery(
      '''SELECT * FROM utilisateur WHERE email = ? ''',
      [email],
    );
    if (result.isNotEmpty) {
      final String utilisateurMdp = result.first['mdp'] as String;

      if (hashPassword(mdp) == utilisateurMdp) {
        return result.first['idUtilisateur'] as int;
      } else {
        return -1;
      }
    }
    return -2;
  }

  // Modifier un utilisateur
  Future<void> updateUtilisateur(Utilisateur utilisateur) async {
    final Database db = await database;
    await db.update("utilisateur", utilisateur.toMap(),
        where: "idUtilisateur = ?", whereArgs: [utilisateur.idUtilisateur]);
  }

  // Supprimer un utilisateur
  Future<void> deleteUtilisateur(Utilisateur utilisateur) async {
    final Database db = await database;
    db.delete("utilisateur",
        where: "idUtilisateur = ?", whereArgs: [utilisateur.idUtilisateur]);
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
      nom: "Admin",
      prenom: "Administrateur",
      email: "pprostwater@ensc.fr",
      mdp: hashPassword("12345678"),
      promotion: 2026,
    ),
  ];
}
