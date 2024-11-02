import 'package:flutter/material.dart';
import 'package:comunique2024/widget/filter_homeScreen.dart';
import 'package:comunique2024/widget/card_home.dart';

// Classe modèle pour un événement
class Event {
  final String office;
  final String role;
  final String eventTitle;
  final String eventDate;
  final String eventTime;
  final String eventLocation;
  final String imageUrl;
  final Color color;
  bool isPinned;

  Event({
    required this.office,
    required this.role,
    required this.eventTitle,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
    required this.imageUrl,
    required this.color,
    this.isPinned = false,
  });


}

class FileActualite extends StatefulWidget {
  @override
  _FileActualiteState createState() => _FileActualiteState();
}

class _FileActualiteState extends State<FileActualite> {
  List<String> activeFilters = [];
  bool isPinFilterActive = false;

// Liste statique d'événements
  final List<Event> events = [
    Event(
      office: "JE",
      role: "Présidente i2c",
      eventTitle: 'Formation i2c',
      eventDate: 'Le jeudi 16 novembre 2023',
      eventTime: 'De 12h30 à 14h',
      eventLocation: 'Salle S103',
      imageUrl: 'https://via.placeholder.com/150',
      color: const Color.fromRGBO(187, 208, 143, 0.71),
    ),
    Event(
      office: "BDS",
      role: "Respo WES",
      eventTitle: 'WES',
      eventDate: 'Du 12 au 14 janvier 2024',
      eventTime: '',
      eventLocation: 'Station Pas de la Case, Andorre',
      imageUrl: 'https://via.placeholder.com/150',
      color: const Color.fromRGBO(167, 222, 219, 0.71),
    ),
    Event(
      office: "BDA",
      role: "Club musique",
      eventTitle: 'Répétition',
      eventDate: 'Le mardi 21 septembre 2023',
      eventTime: 'De 12h30 à 13h30',
      eventLocation: 'Salle S103',
      imageUrl: 'https://via.placeholder.com/150',
      color: const Color.fromRGBO(245, 233, 171, 0.71),
    ),
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
    List<Event> filteredEvents = events;

    // Appliquer les filtres par office
    if (activeFilters.isNotEmpty) {
      filteredEvents = filteredEvents.where((event) => activeFilters.contains(event.office)).toList();
    }

    // Appliquer le filtre épingle si actif
    if (isPinFilterActive) {
      filteredEvents = filteredEvents.where((event) => event.isPinned).toList();
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
                  office: event.office,
                  role: event.role,
                  eventTitle: event.eventTitle,
                  eventDate: event.eventDate,
                  eventTime: event.eventTime,
                  eventLocation: event.eventLocation,
                  imageUrl: event.imageUrl,
                  color: event.color,
                  // Gérer l'état de l'épingle pour chaque carte
                  isPinned: event.isPinned,
                  onPinToggle: () {
                    setState(() {
                      event.isPinned = !event.isPinned;
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
