import 'package:flutter/material.dart';
import 'package:comunique2024/widget/filter_homeScreen.dart';
import 'package:comunique2024/widget/card_home.dart';

class FileActualite extends StatefulWidget {
  @override
  _FileActualiteState createState() => _FileActualiteState();
}

class _FileActualiteState extends State<FileActualite> {
  List<String> activeFilters = [];
  bool isPinFilterActive = false;

// Liste statique d'événements
  final List<Map<String, dynamic>> events = [
    {
      "office": "JE",
      "role": "Présidente i2c",
      "object":"Conférence",
      "eventTitle": 'Formation i2c',
      "eventDate": 'Le jeudi 16 novembre 2023',
      "eventTime": 'De 12h30 à 14h',
      "eventLocation": 'Salle S103',
      "imageUrl": 'https://via.placeholder.com/150',
      "color": const Color.fromRGBO(187, 208, 143, 0.71),
      "isPinned" : false,
    },
    {
      "office": "BDS",
      "role": "Respo WES",
      "object":"Sortie",
      "eventTitle": 'WES',
      "eventDate": 'Du 12 au 14 janvier 2024',
      "eventTime": '',
      "eventLocation": 'Station Pas de la Case, Andorre',
      "imageUrl": 'https://via.placeholder.com/150',
      "color": const Color.fromRGBO(167, 222, 219, 0.71),
      "isPinned" : false,
    },
    {
      "office": "BDA",
      "role": "Club musique",
      "object": "Rencontre Club",
      "eventTitle": 'Répétition',
      "eventDate": 'Le mardi 21 septembre 2023',
      "eventTime": 'De 12h30 à 13h30',
      "eventLocation": 'Salle S103',
      "imageUrl": 'https://via.placeholder.com/150',
      "color": const Color.fromRGBO(245, 233, 171, 0.71),
      "isPinned" : false,
    },
  ];

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
    List<Map<String, dynamic>> filteredEvents = events;

    // Appliquer les filtres par office
    if (activeFilters.isNotEmpty) {
      filteredEvents = filteredEvents.where((event) {
        // Vérifier si l'événement correspond à un filtre actif dans "office" ou "object"
    return activeFilters.contains(event["office"]) | activeFilters.contains(event["object"]);
  }).toList();
}

    // Appliquer le filtre épingle si actif
    if (isPinFilterActive) {
      filteredEvents =
          filteredEvents.where((event) => event["isPinned"] == true).toList();
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
            child: ListView(
              children: filteredEvents.map((event) {
                return CardHome(
                  office: event["office"],
                  role: event["role"],
                  object : event["object"],
                  eventTitle: event["eventTitle"],
                  eventDate: event["eventDate"],
                  eventTime: event["eventTime"],
                  eventLocation: event["eventLocation"],
                  imageUrl: event["imageUrl"],
                  color: event["color"],
                  // Gérer l'état de l'épingle pour chaque carte
                  isPinned: event["isPinned"],
                  onPinToggle: () {
                    setState(() {
                      event["isPinned"] = !event["isPinned"];
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
