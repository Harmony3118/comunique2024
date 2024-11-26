import 'package:flutter/material.dart';
import 'package:comunique2024/widget/filter_homeScreen.dart';
import 'package:comunique2024/widget/card_home.dart';
import 'bdd/bdd.dart';
import 'bdd/event.dart';
import 'bdd/role.dart';
import 'bdd/organisation.dart';
import 'bdd/utilisateur.dart';
class FileActualite extends StatefulWidget {
  @override
  _FileActualiteState createState() => _FileActualiteState();
}

// class _FileActualiteState extends State<FileActualite> {
//   List<String> activeFilters = [];
//   bool isPinFilterActive = false;

// Liste statique d'événements
// final List<Map<String, dynamic>> events = [
//   {
//     "office": "JE",
//     "role": "Présidente i2c",
//     "eventTitle": 'Formation i2c',
//     "eventDate": 'Le jeudi 16 novembre 2023',
//     "eventTime": 'De 12h30 à 14h',
//     "eventLocation": 'Salle S103',
//     "imageUrl": 'https://via.placeholder.com/150',
//     "color": const Color.fromRGBO(187, 208, 143, 0.71),
//     "isPinned": false,
//   },
//   {
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



class _FileActualiteState extends State<FileActualite> {
  List<String> activeFilters = [];
  bool isPinFilterActive = false;
  List<Widget> cards = [];
  bool isLoading = true;

  void initState() {
    super.initState();
    _loadEvents(); // Charger les événements au démarrage
  }

  void _loadEvents() async {
    List<Widget> newCards = await afficherListEvents();
    setState(() {
      cards = newCards;
      isLoading = false;
    });
  }

  // Fonction de mise à jour des filtres
  void _onFilterChanged(List<String> selectedFilters) {
    setState(() {
      activeFilters = selectedFilters;
    });
  }

  void _togglePinFilter() {
    setState(() {
      isPinFilterActive = !isPinFilterActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtrer les événements en fonction des filtres actifs et du filtre épingle
    // List<Map<String, dynamic>> filteredEvents = events;
    List<Widget> filteredEvents = cards;

    // Appliquer les filtres par office
    if (activeFilters.isNotEmpty) {
      filteredEvents = filteredEvents.where((card) {
        if (card is CardHome) {
          return activeFilters.contains(card.office) || activeFilters.contains(card.object);
        }
        return false;
      }).toList();
    }

    // Appliquer le filtre épingle si actif
    if (isPinFilterActive) {
      filteredEvents = filteredEvents.where((card) {
        if (card is CardHome) {
          return card.isPinned;
        }
        return false;
      }).toList();
    }

    


    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: Filter(
              onFilterChanged: _onFilterChanged,
              isPinFilterActive: isPinFilterActive,
              onPinFilterToggle: _togglePinFilter,
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredEvents.isEmpty
                    ? Center(child: Text('Aucun événement trouvé.'))
                    : ListView(children: filteredEvents),
          ),
        ],
      ),
    );
  }

  Future<List<Widget>> afficherListEvents() async {
    final db = await AppDataBase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('event');
    print("Liste de maps ${maps}");
    List<Event> evenements = List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
    List<Widget> newCards = [];

    for (Event e in evenements) {
      List<Map<String, dynamic>> map1 = await db.query("Organisation",
          where: "idOrga = ?", whereArgs: [e.idOrganisation]);
      Organisation o = Organisation.fromMap(map1.first);
      List<Map<String, dynamic>> map2 =
          await db.query("role", where: "idRole = ?", whereArgs: [e.status]);
      Role r = Role.fromMap(map2.first);

      bool b = false;
      // List<Map<String, dynamic>> inscription = await db.query("inscription", where: "idUtilisateur = ?");

      // il faut modifier ça, afficher la bonne couleur pour chaque organisation
      // Gérer l'état de l'épingle pour chaque carte
      newCards.add(CardHome(
        object: e.objet,
        office: o.nom,
        role: r.nomRole,
        eventTitle: e.titre,
        eventDate: e.date ?? 'Date non définie',
        eventTime: formatTimeInterval(e.hDebut, e.hFin),
        eventLocation: e.lieu,
        imageData: o.imageData,
        color: Color(o.color),
        // il faut modifier ça, afficher la bonne couleur pour chaque organisation
        price: e.tarif,
        moreInfo: e.commentaire,
        // Gérer l'état de l'épingle pour chaque carte
        isPinned:
            b, // a ajouter, /!\ ne pas rajouter cela dans event mais dans la table inscription
        onPinToggle: () {
          setState(() {
            b = !b;
            // modifier aussi la table inscription (vérif valeur vérité)
          });
        },
      ));
    }
    return newCards;
  }
}
