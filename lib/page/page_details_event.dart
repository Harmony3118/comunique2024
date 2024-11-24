import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'semaine.dart';
import 'jour.dart';
import 'bdd/bdd.dart';
import 'bdd/event.dart';
import 'bdd/organisation.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/jourselection.dart';
import 'package:comunique2024/widget/card_home.dart';


class EventDetails extends StatelessWidget {
  final Map<String, dynamic> event;

  EventDetails({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0), 
          child: Center(
            child: Text(
              "Détail de l'évènement ",
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            // mettre l'event
            child: CardHome(
          office: event['office'] ?? "Bureau inconnu",
          role: event['role'] ?? "Rôle inconnu",
          eventTitle: event['titre'] ?? "Titre inconnu",
          eventDate: event['date'] ?? "Date inconnue",
          eventTime: formatTimeInterval(event['hDebut'], event['hFin']),
          eventLocation: event['location'] ?? "Lieu inconnu",
          imageData: event['imageData'], // Si vous avez une image, sinon mettez null
          color: Color(event['color']),
          price: event['price'] ?? 0.0,
          moreInfo: event['moreInfo'] ?? "Aucune information supplémentaire",
          isPinned: event['isPinned'] ?? false,
          onPinToggle: () {
            // Implémentez une logique pour épingler/désépingler si nécessaires
            },
        ),
        ),
      ),
      ],
      ),
    );
  }
}