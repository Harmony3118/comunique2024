
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'bdd/bdd.dart';
import 'bdd/event.dart';
import 'bdd/organisation.dart';

class JourSelection extends StatelessWidget {
  final DateTime selectedDate;

  JourSelection({required this.selectedDate});

  Future<List<Map<String, dynamic>>> _fetchEventsForDay(DateTime day) async {
    final db = await AppDataBase.instance.database;
    final String dayString = DateFormat('yyyy-MM-dd').format(day);

    // Récupérer les événements pour le jour sélectionné
    final List<Map<String, dynamic>> maps = await db.query(
      'event',
      where: 'date = ?',
      whereArgs: [dayString],
    );

    List<Map<String, dynamic>> eventsWithColor = [];
    for (var eventMap in maps) {
      // Ajouter les informations de l'organisation
      final List<Map<String, dynamic>> orgaMaps = await db.query(
        'organisation',
        where: 'idOrga = ?',
        whereArgs: [eventMap['idOrganisation']],
      );
      final Organisation orga = Organisation.fromMap(orgaMaps.first);
      eventsWithColor.add({...eventMap, 'color': orga.color});
    }

    return eventsWithColor;
  }

  @override
  Widget build(BuildContext context) {
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
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchEventsForDay(selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Erreur: ${snapshot.error}"));
                }

                final events = snapshot.data ?? [];
                return _buildScheduleWithEvents(events);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleWithEvents(List<Map<String, dynamic>> events) {
    // Convertir les heures de début et fin en objets `DateTime` pour les positions
    Map<int, List<Map<String, dynamic>>> eventsByHour = {};
    for (int hour = 8; hour < 24; hour++) {
      eventsByHour[hour] = [];
    }

    for (var event in events) {
      final startHour = int.parse(event['hDebut'].split(':')[0]);
      eventsByHour[startHour]?.add(event);
    }

    return Column(
      children: [
        for (int hour = 8; hour < 24; hour++) // Horaires de 8h à 23h
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(height: 40),
                  Text('$hour h 00', style: TextStyle(fontSize: 16)),
                  SizedBox(width: 8),
                  Expanded(child: Divider(color: Colors.grey)), // Ligne
                ],
              ),
              for (var event in eventsByHour[hour]!) // Événements de cette heure
                Container(
                  margin: EdgeInsets.only(left: 16, top: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(event['color']),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    event['titre'],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
