import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('EEEE d MMMM ', 'fr_FR').format(now);
    
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$formattedDate ', // Jour de la semaine
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Gras
          ),
        ],
      ),
      );
  }
}

class JourSelection extends StatelessWidget {
  final DateTime selectedDate;

  JourSelection({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    // Formater la date pour l'affichage
    final String formattedDate =
        DateFormat('EEEE d MMMM', 'fr_FR').format(selectedDate);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Color.fromARGB(255, 51, 51, 51)),
              onPressed: () {
                Navigator.pop(context); // Retourner à la page précédente
              },
            ),
              ],
            ),
            SizedBox(height: 40),
            Center(
              child: Text(
                formattedDate, // Affiche la date sélectionnée
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 40),
            Divider(thickness: 1, color: Colors.grey), // Ligne de séparation
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Afficher tous les horaires
                  for (int hour = 8; hour < 24; hour++) // Horaires de 8h à 23h
                    Row(
                      children: [
                        SizedBox(height: 40),
                        Text('$hour h 00', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Expanded(child: Divider(color: Colors.grey)), // Ligne
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}