
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'bdd/bdd.dart';
import 'bdd/organisation.dart';
import 'package:comunique2024/page/page_details_event.dart';
import 'package:comunique2024/page/page_navigation.dart';

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
    return _buildScheduleWithEvents(context, events); // Passer le contexte ici
  },
),

          ],
        ),
      ),
    );
  }

Widget _buildScheduleWithEvents(BuildContext context, List<Map<String, dynamic>> events) {
  Map<int, List<Map<String, dynamic>>> eventsByHour = {};
  for (int hour = 8; hour < 24; hour++) {
    eventsByHour[hour] = [];
  }

  for (var event in events) {
    final startHour = int.parse(event['hDebut'].split(':')[0]);
    final endHour = int.parse(event['hFin'].split(':')[0]);

    for (int hour = startHour; hour < endHour; hour++) {
      eventsByHour[hour]?.add({...event, 'startHour': startHour});
    }
  }

  return Column(
    children: [
      for (int hour = 8; hour < 24; hour++)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text('$hour h 00', style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
              ],
            ),
            SizedBox(width: 8),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (eventsByHour[hour] == null || eventsByHour[hour]!.isEmpty)
                    Expanded(child: Divider(color: Colors.grey))
                  else
                    for (var event in eventsByHour[hour]!)
                      if (event['startHour'] == hour)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BasePage(currentIndex: 4, body:EventDetails(event: event)),
                                ),
                              );
                            },
                            child: Container(
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
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
    ],
  );
}
}
